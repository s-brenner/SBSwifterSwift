import XCTest
@testable import SBSwifterSwift

final class ArrayExtensionsTests: XCTestCase {
    
    func testOverlappingPairs() {
        XCTAssertEqual([1, 2, 3, 4].overlappingPairs, [[1, 2], [2, 3], [3, 4]])
        XCTAssertEqual([1].overlappingPairs, [])
        XCTAssertEqual([Int]().overlappingPairs, [])
    }
    
    func testRemoveDuplicates() {
        var array = [1, 2, 2, 3, 3, 3, 4]
        array.removeDuplicates()
        XCTAssertEqual(array, [1, 2, 3, 4])
    }
    
    func testWithoutDuplicates() {
        let array = [1, 2, 2, 3, 3, 3, 4]
        XCTAssertEqual(array.withoutDuplicates(), [1, 2, 3, 4])
    }
}
