import XCTest
@testable import SBSwifterSwift

final class ComparableExtensionsTests: XCTestCase {
    
    func testClamped() {
        XCTAssertEqual(Float(9.3).clamped(to: 3.2...6.1), 6.1)
        XCTAssertEqual(Double(-2.3).clamped(to: 0...1), 0)
        XCTAssertEqual(Double(-4.2).clamped(to: -10...10), -4.2)
        XCTAssertEqual(3.clamped(to: 0...2), 2)
    }
}
