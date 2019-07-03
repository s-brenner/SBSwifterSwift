import XCTest
@testable import SBSwifterSwift

final class RangeReplaceableCollectionExtensionsTests: XCTestCase {
    
    // MARK: - Tests
    
    func testRemoveAllElements() {
        var string = "This is a test."
        string.removeAll(["h", "t"])
        XCTAssertEqual(string, "Tis is a es.")
    }
    
    func testRemovingAllElements() {
        self.measure {
            let array = [1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1]
            XCTAssertEqual(array.removingAll([3, 1]), [2, 4, 5, 6, 5, 4, 2])
        }
    }
}
