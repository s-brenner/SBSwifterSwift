import XCTest
@testable import SBSwifterSwift

final class FloatExtensionsTests: XCTestCase {
    
    func testDouble() {
        XCTAssertEqual(Float(-1).double, Double(-1))
        XCTAssertEqual(Float(2).double, Double(2))
        XCTAssertEqual(Float(4.3).double, Double(4.3), accuracy: 0.00001)
    }
    
    func testCGFloat() {
        XCTAssertEqual(Float(4.3).cgFloat, CGFloat(4.3), accuracy: 0.00001)
    }
}
