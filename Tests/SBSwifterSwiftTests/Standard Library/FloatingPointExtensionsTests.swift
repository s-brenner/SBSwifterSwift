import XCTest
@testable import SBSwifterSwift

final class FloatingPointExtensionsTests: XCTestCase {
    
    func testAbs() {
        XCTAssertEqual(Float(-9.3).abs, Float(9.3))
        XCTAssertEqual(Double(-9.3).abs, Double(9.3))
    }
    
    func testIsPositive() {
        XCTAssert(Float(1).isPositive)
        XCTAssertFalse(Float(0).isPositive)
        XCTAssertFalse(Float(-1).isPositive)
        
        XCTAssert(Double(1).isPositive)
        XCTAssertFalse(Double(0).isPositive)
        XCTAssertFalse(Double(-1).isPositive)
    }
    
    func testIsNegative() {
        XCTAssert(Float(-1).isNegative)
        XCTAssertFalse(Float(0).isNegative)
        XCTAssertFalse(Float(1).isNegative)
        
        XCTAssert(Double(-1).isNegative)
        XCTAssertFalse(Double(0).isNegative)
        XCTAssertFalse(Double(1).isNegative)
    }
    
    func testCeil() {
        XCTAssertEqual(Float(9.3).ceil, Float(10.0))
        XCTAssertEqual(Double(9.3).ceil, Double(10.0))
    }
    
    func testDegreesToRadians() {
        XCTAssertEqual(Float(180).degreesToRadians, .pi)
        XCTAssertEqual(Double(180).degreesToRadians, .pi)
    }
    
    func testFloor() {
        XCTAssertEqual(Float(9.3).floor, Float(9.0))
        XCTAssertEqual(Double(9.3).floor, Double(9.0))
    }
    
    func testRadiansToDegrees() {
        XCTAssertEqual(Float.pi.radiansToDegrees, Float(180))
        XCTAssertEqual(Double.pi.radiansToDegrees, Double(180))
    }
    
    func testClamped() {
        XCTAssertEqual(Float(9.3).clamped(to: 3.2...6.1), 6.1)
        XCTAssertEqual(Double(-2.3).clamped(to: 0...1), 0)
        XCTAssertEqual(Double(-4.2).clamped(to: -10...10), -4.2)
    }
}
