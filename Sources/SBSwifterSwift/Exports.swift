#if canImport(Combine)
@_exported import Combine
#endif

#if canImport(Foundation)
@_exported import Foundation
#endif

#if canImport(CoreData)
@_exported import class    CoreData.NSManagedObjectContext
#endif

#if canImport(CoreGraphics)
@_exported import struct   CoreGraphics.CGFloat
@_exported import struct   CoreGraphics.CGSize
#endif

#if canImport(CoreLocation)
@_exported import class    CoreLocation.CLLocation
@_exported import struct   CoreLocation.CLLocationDegrees
@_exported import struct   CoreLocation.CLLocationCoordinate2D
@_exported import let      CoreLocation.kCLLocationCoordinate2DInvalid
#endif

#if canImport(CryptoKit)
@_exported import struct   CryptoKit.SymmetricKey
#endif

#if canImport(MapKit)
@_exported import protocol MapKit.MKAnnotation
@_exported import class    MapKit.MKAnnotationView
@_exported import struct   MapKit.MKCoordinateRegion
@_exported import struct   MapKit.MKCoordinateSpan
@_exported import class    MapKit.MKMapSnapshotter
@_exported import enum     MapKit.MKMapType
@_exported import class    MapKit.MKMapView
@_exported import class    MapKit.MKPointOfInterestFilter
@_exported import class    MapKit.MKPolyline
#endif

#if canImport(SBLogging)
@_exported import           SBLogging
#endif

#if canImport(UIKit)
@_exported import class    UIKit.UIScreen
#endif
