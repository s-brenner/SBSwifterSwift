import XCTest
@testable import SBSwifterSwift

final class LocaleExtensionsTests: XCTestCase {
    
    // MARK: - Tests
    
    func testCases() {
        let identifiers = Locale.Identifier.allCases
        if identifiers.count != Locale.underscoredAvailableIdentifiers.count {
            print("\n\n")
            print(Locale.cases.joined(separator: "\n"))
            print("\n\n")
        }
        XCTAssertEqual(identifiers.count, Locale.underscoredAvailableIdentifiers.count)
    }
}
