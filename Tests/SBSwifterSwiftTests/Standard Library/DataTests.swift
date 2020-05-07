import XCTest
@testable import SBSwifterSwift

final class DataExtensionsTests: XCTestCase {
        
    func testString() {
        
        let data = "Foo".data(using: .utf8)!
        
        XCTAssertEqual(data.string(), String(data: data, encoding: .utf8))
    }
}
