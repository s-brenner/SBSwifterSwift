import XCTest
@testable import SBFoundation

final class LocaleExtensionsTests: XCTestCase {
    
    func testCases() {
        let identifiers = Locale.allCases
        if identifiers.count != Locale.underscoredAvailableIdentifiers.count {
            print("\n\n")
            print(Locale.staticLocales.joined(separator: "\n\n"))
//            print(Locale.allCasesBuilder.joined(separator: "\n"))
            print("\n\n")
        }
        XCTAssertEqual(identifiers.count, Locale.underscoredAvailableIdentifiers.count)
    }
}
