#if canImport(MapKit)
import Foundation
import struct CoreLocation.CLLocationCoordinate2D
import let    CoreLocation.kCLLocationCoordinate2DInvalid
import class  MapKit.MKPolyline

public extension MKPolyline {
    
    /// Return an Array of coordinates representing the provided polyline.
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }
    
    /// Create a new MKPolyline from a provided Array of coordinates.
    /// - Parameter coordinates: Array of coordinates.
    convenience init(coordinates: [CLLocationCoordinate2D]) {
        var refCoordinates = coordinates
        self.init(coordinates: &refCoordinates, count: refCoordinates.count)
    }
}
#endif
