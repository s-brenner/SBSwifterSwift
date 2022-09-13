#if canImport(MapKit) && os(iOS)
import struct CoreGraphics.CGFloat
import struct CoreGraphics.CGSize
import struct CoreLocation.CLLocationCoordinate2D
import struct MapKit.MKCoordinateRegion
import class  MapKit.MKMapSnapshotter
import enum   MapKit.MKMapType
import class  MapKit.MKPointOfInterestFilter
import class  UIKit.UIScreen

extension MKMapSnapshotter.Options {
    
    @available(iOS 13.0, *)
    public convenience init(
        coordinates: [CLLocationCoordinate2D],
        size: CGSize,
        scale: CGFloat = UIScreen.main.scale,
        mapType: MKMapType = .standard,
        showsBuildings: Bool = true,
        pointOfInterestFilter: MKPointOfInterestFilter? = nil) throws {
        
        self.init()
        
        // Region
        region = try MKCoordinateRegion(coordinates: coordinates)

        // Map data
        self.mapType = mapType
        self.showsBuildings = showsBuildings
        self.pointOfInterestFilter = pointOfInterestFilter
        
        // Image output
        self.size = size
        self.scale = scale
    }
}
#endif
