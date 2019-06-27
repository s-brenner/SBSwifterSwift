import XCTest
import CoreLocation
@testable import SBSwifterSwift

final class CLLocationExtensionsTests: XCTestCase {
    
    let rodn = CLLocation(latitude: 26.36, longitude: 127.77)
    
    let phnl = CLLocation(latitude: 21.32, longitude: -157.92)
    
    func textGreatCircleRoute() {
        XCTAssertTrue(rodn.greatCircleRoute(to: rodn).isEmpty)
        XCTAssertEqual(rodn.greatCircleRoute(to: phnl).first!.coordinate, rodn.coordinate)
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
