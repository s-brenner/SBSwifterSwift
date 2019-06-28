import MapKit

extension MKPolyline {
    
    // MARK: - Properties
    
    /// Return an Array of coordinates representing the provided polyline.
    public var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }
    
    
    // MARK: - Initializers
    
    /// Create a new MKPolyline from a provided Array of coordinates.
    /// - Parameter coordinates: Array of coordinates.
    public convenience init(coordinates: [CLLocationCoordinate2D]) {
        var refCoordinates = coordinates
        self.init(coordinates: &refCoordinates, count: refCoordinates.count)
    }
}
