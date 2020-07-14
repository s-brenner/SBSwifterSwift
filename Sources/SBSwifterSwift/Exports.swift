@_exported import Combine
@_exported import Foundation
@_exported import os

@_exported import class    CoreData.NSManagedObjectContext

@_exported import struct   CoreGraphics.CGFloat
@_exported import struct   CoreGraphics.CGSize

@_exported import class    CoreLocation.CLLocation
@_exported import struct   CoreLocation.CLLocationDegrees
@_exported import struct   CoreLocation.CLLocationCoordinate2D
@_exported import let      CoreLocation.kCLLocationCoordinate2DInvalid

@_exported import struct   CryptoKit.SymmetricKey

@_exported import protocol MapKit.MKAnnotation
@_exported import class    MapKit.MKAnnotationView
@_exported import struct   MapKit.MKCoordinateRegion
@_exported import struct   MapKit.MKCoordinateSpan
@_exported import class    MapKit.MKMapSnapshotter
@_exported import enum     MapKit.MKMapType
@_exported import class    MapKit.MKMapView
@_exported import class    MapKit.MKPointOfInterestFilter
@_exported import class    MapKit.MKPolyline

#if !os(macOS)
@_exported import class    UIKit.UIScreen
#endif
