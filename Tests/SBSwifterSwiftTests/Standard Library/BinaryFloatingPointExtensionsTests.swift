import XCTest
import CoreGraphics
@testable import SBSwifterSwift

final class BinaryFloatingPointExtensionsTests: XCTestCase {
    
    func testInt() {
        XCTAssertEqual(Double(-1).int, -1)
        XCTAssertEqual(Double(2).int, 2)
        XCTAssertEqual(Double(4.3).int, 4)
        
        XCTAssertEqual(Float(-1).int, -1)
        XCTAssertEqual(Float(2).int, 2)
        XCTAssertEqual(Float(4.3).int, 4)
        
        XCTAssertEqual(CGFloat(-1).int, -1)
        XCTAssertEqual(CGFloat(2).int, 2)
        XCTAssertEqual(CGFloat(4.3).int, 4)
    }
}
