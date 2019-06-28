import XCTest
import CoreLocation
@testable import SBSwifterSwift

final class CLLocationExtensionsTests: XCTestCase {
    
    let rodn = CLLocation(latitude: 26.36, longitude: 127.77)
    
    let phnl = CLLocation(latitude: 21.32, longitude: -157.92)
    
    func testInit() {
        let location = CLLocation(coordinate: rodn.coordinate)
        XCTAssertEqual(location.coordinate, rodn.coordinate)
        XCTAssertEqual(location.altitude, 0)
        XCTAssertEqual(location.horizontalAccuracy, 0)
        XCTAssertEqual(location.verticalAccuracy, -1)
        XCTAssertEqual(location.speed, -1)
        XCTAssertEqual(location.course, -1)
    }
    
    func testGreatCircleRoute() {
        // Test an empty route
        let emptyRoute = rodn.greatCircleRoute(to: rodn)
        XCTAssertTrue(emptyRoute.isEmpty)
        
        // Test that the first and last points are as expected
        let route = rodn.greatCircleRoute(to: phnl)
        XCTAssertEqual(route.first!.coordinate.latitude, rodn.coordinate.latitude, accuracy: 0.0001)
        XCTAssertEqual(route.first!.coordinate.longitude, rodn.coordinate.longitude, accuracy: 0.0001)
        XCTAssertEqual(route.last!.coordinate.latitude, phnl.coordinate.latitude, accuracy: 0.0001)
        XCTAssertEqual(route.last!.coordinate.longitude, phnl.coordinate.longitude, accuracy: 0.0001)
        
        // Test if points are less than or equal to 25 kilometers apart
        let random = Int.random(in: 1...route.count - 1)
        XCTAssertLessThanOrEqual(route[random].distance(from: route[random - 1]), 25_000)
    }
    
    func testBearing() {
        XCTAssertEqual(rodn.bearing(to: phnl), 76.5846, accuracy: 0.0001)
        XCTAssertEqual(phnl.bearing(from: rodn), 110.6745, accuracy: 0.0001)
    }
    
    func testMidLocation() {
        let midLocation = rodn.midLocation(to: phnl)
        XCTAssertEqual(midLocation.coordinate.latitude, 29.0029, accuracy: 0.0001)
        XCTAssertEqual(midLocation.coordinate.longitude, 165.7693, accuracy: 0.0001)
    }
}
