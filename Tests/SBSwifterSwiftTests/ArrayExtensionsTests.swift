import XCTest
@testable import SBSwifterSwift

final class ArrayExtensionsTests: XCTestCase {
    
    func testOverlappingPairs() {
        XCTAssert([1, 2, 3, 4].overlappingPairs == [[1, 2], [2, 3], [3, 4]])
        XCTAssert([1].overlappingPairs == [])
        XCTAssert([Int]().overlappingPairs == [])
    }
    
    func testRemoveDuplicates() {
        var array = [1, 2, 2, 3, 3, 3, 4]
        array.removeDuplicates()
        XCTAssert(array == [1, 2, 3, 4])
    }
    
    func testWithoutDuplicates() {
        let array = [1, 2, 2, 3, 3, 3, 4]
        XCTAssert(array.withoutDuplicates() == [1, 2, 3, 4])
    }
}
