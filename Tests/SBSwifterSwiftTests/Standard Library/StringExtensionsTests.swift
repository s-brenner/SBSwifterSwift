import XCTest
@testable import SBSwifterSwift

final class StringExtensionsTests: XCTestCase {
    
    func testCamelCased() {
        XCTAssertEqual("SoMe vAriable naMe".camelCased, "someVariableName")
    }
}
