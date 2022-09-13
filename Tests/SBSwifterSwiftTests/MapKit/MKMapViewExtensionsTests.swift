#if !os(watchOS)
import XCTest
import MapKit
@testable import SBSwifterSwift

final class MKMapViewTests: XCTestCase {
    
    @available(iOS 11.0, tvOS 11.0, macOS 10.13, *)
    func testRegister() {
        let mapView = MKMapView()
        
        mapView.register(annotationViewWithClass: MKPinAnnotationView.self)
        let annotationView = mapView.dequeueReusableAnnotationView(withClass: MKPinAnnotationView.self)
        XCTAssertNotNil(annotationView)
    }
    
    @available(iOS 11.0, tvOS 11.0, macOS 10.13, *)
    func testRegisterAndDequeue() {
        let mapView = MKMapView()
        let annotation = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        
        mapView.register(annotationViewWithClass: MKPinAnnotationView.self)
        let annotationViewWithAnnotation = mapView.dequeueReusableAnnotationView(withClass: MKPinAnnotationView.self, for: annotation)
        XCTAssertNotNil(annotationViewWithAnnotation)
    }
}
#endif
