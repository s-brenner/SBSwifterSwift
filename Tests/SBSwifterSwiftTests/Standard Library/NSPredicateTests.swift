import XCTest
@testable import SBSwifterSwift

final class NSPredicateTests: XCTestCase {
    
    // MARK: - Types
    
    @objc private class Person: NSObject {
        @objc var name: String
        @objc var age: Int
        
        /// Age 32.
        static let james = Person(name: "James", age: 32)
        
        /// Age 36.
        static let wade = Person(name: "Wade", age: 36)
        
        /// Age 29.
        static let rose = Person(name: "Rose", age: 29)
        
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }
    
    
    // MARK: - Tests
    
    private let array: [Person] = [.james, .wade, .rose]
    private lazy var nsArray = NSArray(array: array)
    
    func testComparisonOperators() {

        XCTAssertEqual(nsArray.filtered(using: \Person.name == "James") as! [Person], [.james])
        XCTAssertEqual(nsArray.filtered(using: \Person.name != "James") as! [Person], [.wade, .rose])
        XCTAssertEqual(nsArray.filtered(using: \Person.age > 32) as! [Person], [.wade])
        XCTAssertEqual(nsArray.filtered(using: \Person.age < 32) as! [Person], [.rose])
        XCTAssertEqual(nsArray.filtered(using: \Person.age <= 32) as! [Person], [.james, .rose])
        XCTAssertEqual(nsArray.filtered(using: \Person.age >= 32) as! [Person], [.james, .wade])
        XCTAssertEqual(nsArray.filtered(using: \Person.name === ["James", "Scott"]) as! [Person], [.james])
    }
    
    func testCompoundOperators() {
        
        let nameIsJames = \Person.name == "James"
        let ageIsLessThan33 = \Person.age < 33
        
        XCTAssertEqual(nsArray.filtered(using: nameIsJames && ageIsLessThan33) as! [Person], [.james])
        XCTAssertEqual(nsArray.filtered(using: nameIsJames || ageIsLessThan33) as! [Person], [.james, .rose])
        XCTAssertEqual(nsArray.filtered(using: !nameIsJames) as! [Person], [.wade, .rose])
    }
}
