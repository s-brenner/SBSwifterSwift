import XCTest
@testable import SBSwifterSwift

final class DoubleExtensionsTests: XCTestCase {
        
    func testFloat() {
        XCTAssertEqual(Double(-1).float, Float(-1))
        XCTAssertEqual(Double(2).float, Float(2))
        XCTAssertEqual(Double(4.3).float, Float(4.3))
    }
    
    func testCGFloat() {
        XCTAssertEqual(Double(4.3).cgFloat, CGFloat(4.3))
    }
}
