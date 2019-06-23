import MapKit

extension MKCoordinateRegion {
    
    // MARK: - Types
    
    private typealias Transform = (CLLocationCoordinate2D) -> (CLLocationCoordinate2D)
    
    public enum MKCoordinateRegionError: LocalizedError {
        case emptyCoordinateArray
        case paddingOutOfBounds(Double)
        
        public var errorDescription: String? {
            switch self {
            case .emptyCoordinateArray: return "An empty coordinates array is not allowed."
            case let .paddingOutOfBounds(padding): return "The padding value of \(padding) is invalid. It must be between 0 and 0.5."
            }
        }
    }
    
    
    // MARK: - Initializers
    
    /// Makes a region that includes all of the included coordinates.
    /// - Parameter coordinates: The coordinates to center the region around.
    /// - Parameter padding: The percentage of latitude and longitude span to add to each side of the smallest possible region in order to keep the provided coordinates off the edges of the region. Must be between 0 and 0.5. Defaults to 0.05.
    public init(coordinates: [CLLocationCoordinate2D], padding: Double = 0.05) throws {
        
        // Handle edge cases
        guard !coordinates.isEmpty else { throw MKCoordinateRegionError.emptyCoordinateArray }
        guard (0...0.5).contains(padding) else { throw MKCoordinateRegionError.paddingOutOfBounds(padding) }
        
        // First create a region centered around the prime meridian
        let primeRegion: MKCoordinateRegion = try! .region(containing: coordinates, padding: padding)
        
        // Next create a region centered around the 180th meridian
        let transformedRegion: MKCoordinateRegion =
            try! .region(containing: coordinates,
                         padding: padding,
                         transform: MKCoordinateRegion.transform,
                         inverseTransform: MKCoordinateRegion.inverseTransform)
        
        // Return the region that has the smallest longitudinal delta
        let regions = [primeRegion, transformedRegion]
        let smallestRegion = regions.min(by: { $0.span.longitudeDelta < $1.span.longitudeDelta })
        self = smallestRegion ?? primeRegion
    }
    
    
    // MARK: - Helper methods
    
    /// Transforms longitude from -180...180 to 0...360.
    /// - Parameter coordinate: Coordinate to transform
    private static func transform(_ coordinate: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        if coordinate.longitude < 0 {
            return CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: 360 + coordinate.longitude)
        }
        return coordinate
    }
    
    /// Transforms longitude from 0...360 to -180...180.
    /// - Parameter coordinate: Coordinate to transform
    private static func inverseTransform(_ coordinate: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        if coordinate.longitude > 180 {
            return CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: -360 + coordinate.longitude)
        }
        return coordinate
    }
    
    private static func region(containing coordinates: [CLLocationCoordinate2D],
                               padding: Double,
                               transform: Transform = { $0 },
                               inverseTransform: Transform = { $0 }) throws -> MKCoordinateRegion {
        
        // Handle an empty array of coordinates
        guard !coordinates.isEmpty else { throw MKCoordinateRegionError.emptyCoordinateArray }
        
        // Handle a single coordinate
        guard coordinates.count > 1 else {
            let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            return MKCoordinateRegion(center: coordinates[0], span: span)
        }
        
        let transformed = coordinates.map(transform)
        
        // Calculate the latitude extremes
        var minLat = transformed.min { $0.latitude < $1.latitude }!.latitude
        var maxLat = transformed.max { $0.latitude < $1.latitude }!.latitude
        let latPadding = (maxLat - minLat) * padding
        minLat -= latPadding
        maxLat += latPadding
        
        // Calculate the longitude extremes
        var minLon = transformed.min { $0.longitude < $1.longitude }!.longitude
        var maxLon = transformed.max { $0.longitude < $1.longitude }!.longitude
        let lonPadding = (maxLon - minLon) * padding
        minLon -= lonPadding
        maxLon += lonPadding
        
        // Calculate the span
        let span = MKCoordinateSpan(latitudeDelta: maxLat - minLat, longitudeDelta: maxLon - minLon)
        
        // Calculate the center of the span
        let center = inverseTransform(
            CLLocationCoordinate2D(latitude: maxLat - span.latitudeDelta / 2, longitude: maxLon - span.longitudeDelta / 2)
        )
        
        return MKCoordinateRegion(center: center, span: span)
    }
}
