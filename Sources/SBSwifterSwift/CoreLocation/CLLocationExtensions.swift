#if canImport(CoreLocation)
import Foundation
import class  CoreLocation.CLLocation
import struct CoreLocation.CLLocationCoordinate2D
import struct CoreLocation.CLLocationDegrees

extension CLLocation {
    
    // MARK: - Types
    
    private struct GreatCircle {
        
        // MARK: - Types
        
        private typealias Radians = Double
        
        
        // MARK: - Properties
        
        private let lat1: Radians
        
        private let lat2: Radians
        
        private let latDelta: Radians
        
        private let lon1: Radians
        
        private let lon2: Radians
        
        private let lonDelta: Radians
        
        private let angularDistance: Radians
        
        
        // MARK: - Public Initializers
        
        init(start: CLLocation, end: CLLocation) {
            let lat1 = start.coordinate.latitude.degreesToRadians
            let lat2 = end.coordinate.latitude.degreesToRadians
            let latDelta = (end.coordinate.latitude - start.coordinate.latitude).degreesToRadians
            let lonDelta = (end.coordinate.longitude - start.coordinate.longitude).degreesToRadians
            
            self.lat1 = lat1
            self.lat2 = lat2
            self.latDelta = latDelta
            lon1 = start.coordinate.longitude.degreesToRadians
            lon2 = end.coordinate.longitude.degreesToRadians
            self.lonDelta = lonDelta
            angularDistance = {
                let squareOfHalfChordLength = pow(sin(latDelta / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(lonDelta / 2), 2)
                return 2 * atan2(sqrt(squareOfHalfChordLength), sqrt(1 - squareOfHalfChordLength))
            }()
        }
        
        
        // MARK: - Methods
        
        /// Returns a location along the great circle route.
        /// - Parameter routeFraction: The fraction along the great circle route. 0 corresponds to the start location. 1 corresponds to the end location.
        func intermediatePoint(routeFraction: Double) -> CLLocation {
            
            let f = routeFraction.clamped(to: 0...1)
            let a = sin((1 - f) * angularDistance) / sin(angularDistance)
            let b = sin(f * angularDistance) / sin(angularDistance)
            let x = a * cos(lat1) * cos(lon1) + b * cos(lat2) * cos(lon2)
            let y = a * cos(lat1) * sin(lon1) + b * cos(lat2) * sin(lon2)
            let z = a * sin(lat1) + b * sin(lat2)
            let lat = atan2(z, sqrt(pow(x, 2) + pow(y, 2)))
            let lon = atan2(y, x)
            
            return CLLocation(latitude: lat.radiansToDegrees, longitude: lon.radiansToDegrees)
        }
    }
    
    
    // MARK: - Initializers
    
    /// Creates a location object with the specified coordinate.
    ///
    /// Use this method to create location objects that are not necessarily based on the user's current location. Typically, you acquire location objects from your CLLocationManager object, which returns the user's actual location. However, you might use this method when you want to represent any location on a map. For example, you might create an object to represent the user's intended destination.
    ///
    /// This method records the latitude and longitude values you provide, and it initializes other properties to appropriate default values. Specifically, this method sets the `altitude` and `horizontalAccuracy` properties to 0, sets the `verticalAccuracy` property to -1 to indicate that the altitude is invalid, sets the `speed` and `course` values to -1, and sets the `timestamp` property to the time at which the returned object was created.
    /// - Parameter coordinate: A coordinate structure containing the latitude and longitude values.
    /// - Returns: A location object initialized with the specified geographical coordinate.
    public convenience init(coordinate: CLLocationCoordinate2D) {
        
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    
    // MARK: - Methods
    
    /// Calculates the great circle route to the destination.
    /// - Parameter destination: Location to calculate the route.
    /// - Returns: Array of CLLocation values that describe the great circle route.
    public func greatCircleRoute(to destination: CLLocation) -> [CLLocation] {
        
        // Handle the case of identical coordinates
        guard coordinate != destination.coordinate else { return [] }
        
        // Calculate the number of points in the route
        let kilometersPerPoint = 25.0
        let kilometers = destination.distance(from: self) / 1000
        let count = max((kilometers / kilometersPerPoint).ceil.int, 3)
        
        // Calculate the route fractions
        let routeFractions = Array(0...count).map() { Double($0) / Double(count) }
        
        // Calculate the route
        let greatCircle = GreatCircle(start: self, end: destination)
        return routeFractions.map() { greatCircle.intermediatePoint(routeFraction: $0) }
    }
    
    /// Calculates the bearing to another CLLocation.
    /// - Parameter destination: Location to calculate bearing.
    /// - Returns: Calculated bearing degrees in the range 0° ... 360°.
    public func bearing(to destination: CLLocation) -> CLLocationDegrees {
        
        // https://www.movable-type.co.uk/scripts/latlong.html
        
        let lat1 = coordinate.latitude.degreesToRadians
        let lat2 = destination.coordinate.latitude.degreesToRadians
        let lon1 = coordinate.longitude.degreesToRadians
        let lon2 = destination.coordinate.longitude.degreesToRadians
        
        let y = sin(lon2 - lon1) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon2 - lon1)
        let degrees = atan2(y, x).radiansToDegrees
        
        return (degrees + 360).truncatingRemainder(dividingBy: 360)
    }
    
    /// Calculates the bearing from another CLLocation.
    /// - Parameter origin: Location to calculate bearing.
    /// - Returns: Calculated bearing degrees in the range 0° ... 360°.
    public func bearing(from origin: CLLocation) -> CLLocationDegrees {
        (bearing(to: origin) + 180).truncatingRemainder(dividingBy: 360)
    }
    
    /// Calculates the halfway point along a great circle path between two points.
    /// - Parameter start: Start location.
    /// - Parameter end: End location.
    /// - Returns: Location that represents the halfway point.
    public static func midLocation(start: CLLocation, end: CLLocation) -> CLLocation {
        GreatCircle(start: start, end: end).intermediatePoint(routeFraction: 0.5)
    }
    
    /// Calculates the halfway point along a great circle path between self and the destination.
    /// - Parameter destination: End location.
    /// - Returns: Location that represents the halfway point.
    public func midLocation(to destination: CLLocation) -> CLLocation {
        CLLocation.midLocation(start: self, end: destination)
    }
}
#endif
