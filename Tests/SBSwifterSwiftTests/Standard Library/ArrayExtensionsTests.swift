import XCTest
@testable import SBSwifterSwift

final class ArrayExtensionsTests: XCTestCase {
    
    // MARK: - Types
    
    private struct Person: Equatable {
        var name: String
        var age: Int?
        
        /// Age 32.
        static let james = Person(name: "James", age: 32)
        
        /// Age 36.
        static let wade = Person(name: "Wade", age: 36)
        
        /// Age 29.
        static let rose = Person(name: "Rose", age: 29)
        
        /// Unknown age.
        static let scott = Person(name: "Scott", age: nil)
        
        /// Unknown age.
        static let michelle = Person(name: "Michelle", age: nil)
        
        static func == (lhs: Person, rhs: Person) -> Bool {
            return lhs.name == rhs.name && lhs.age == rhs.age
        }
    }
    
    
    // MARK: - Tests
    
    func testPrepend() {
        var array = [2, 3, 4, 5]
        array.prepend(1)
        XCTAssertEqual(array, [1, 2, 3, 4, 5])
    }
    
    func testOverlappingPairs() {
        XCTAssertEqual([1, 2, 3, 4].overlappingPairs, [[1, 2], [2, 3], [3, 4]])
        XCTAssertEqual([1].overlappingPairs, [])
        XCTAssertEqual([Int]().overlappingPairs, [])
    }
    
    func testKeyPathSorted() {
        let array: [Person] = [.james, .wade, .rose]
        
        // Test non-optional keyPath
        XCTAssertEqual(array.sorted(by: \Person.name), [.james, .rose, .wade])
        XCTAssertEqual(array.sorted(by: \Person.name, ascending: false), [.wade, .rose, .james])
        
        // Test optional keyPath
        XCTAssertEqual(array.sorted(by: \Person.age), [.rose, .james, .wade])
        XCTAssertEqual(array.sorted(by: \Person.age, ascending: false), [.wade, .james, .rose])
        
        // Test mutating non-optional keyPath
        var mutableArray: [Person] = [.james, .wade, .rose]
        
        mutableArray.sort(by: \Person.name)
        XCTAssertEqual(mutableArray, [.james, .rose, .wade])
        
        // Testing Mutating Optional keyPath
        mutableArray.sort(by: \Person.age)
        XCTAssertEqual(mutableArray, [.rose, .james, .wade])
        
        // Testing nil path
        let nilArray: [Person] = [.scott, .michelle]
        XCTAssertEqual(nilArray.sorted(by: \Person.age), nilArray)
    }
    
    func testRemoveAll() {
        var arr = [0, 1, 2, 0, 3, 4, 5, 0, 0]
        arr.removeAll(0)
        XCTAssertEqual(arr, [1, 2, 3, 4, 5])
        arr = []
        arr.removeAll(0)
        XCTAssertEqual(arr, [])
    }
    
    func testRemoveAllItems() {
        var arr = [0, 1, 2, 2, 0, 3, 4, 5, 0, 0]
        arr.removeAll([0, 2])
        XCTAssertEqual(arr, [1, 3, 4, 5])
        arr.removeAll([])
        XCTAssertEqual(arr, [1, 3, 4, 5])
        arr = []
        arr.removeAll([])
        XCTAssertEqual(arr, [])
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
