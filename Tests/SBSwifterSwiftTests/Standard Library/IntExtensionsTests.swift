import XCTest
@testable import SBSwifterSwift

final class IntExtensionsTests: XCTestCase {
    
    func testCountableRange() {
        XCTAssertEqual(10.countableRange, 0..<10)
    }
    
    func testDegreesToRadians() {
        XCTAssertEqual(180.degreesToRadians, .pi)
    }
    
    func testRadiansToDegrees() {
        XCTAssertEqual(Int(3.radiansToDegrees), 171)
    }
    
    func testUInt() {
        XCTAssertEqual(Int(10).uInt, UInt(10))
    }
    
    func testDouble() {
        XCTAssertEqual((-1).double, Double(-1))
        XCTAssertEqual(2.double, Double(2))
    }
    
    func testFloat() {
        XCTAssertEqual((-1).float, Float(-1))
        XCTAssertEqual(2.float, Float(2))
    }
    
    func testCGFloat() {
        XCTAssertEqual(1.cgFloat, CGFloat(1))
    }
    
    func testRoundToNearest() {
        XCTAssert(12.roundToNearest(5) == 10)
        XCTAssert(63.roundToNearest(25) == 75)
        XCTAssert(42.roundToNearest(0) == 42)
    }
    
    func testMod() {
        XCTAssertEqual(-1 % 2, -1)
        XCTAssertEqual(-1.mod(2), -1)
        
        XCTAssertEqual(1 % -2, 1)
        XCTAssertEqual(1.mod(-2), -1)
        
        // Test sign and magnitude of the result
        for _ in 0...1_000 {
            let dividend = Int.random(in: -1_000_000...1_000_000)
            let divisor = Int.random(in: -1_000_000...1_000_000)
            let mod = dividend.mod(divisor)
            XCTAssertEqual(mod.isNegative, divisor.isNegative)
            XCTAssertLessThan(mod.abs, divisor.abs)
        }
    }
}
