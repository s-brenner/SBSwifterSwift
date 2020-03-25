import XCTest
@testable import SBSwifterSwift

final class GlobalTests: XCTestCase {
    
    private class Person {
        var name = ""
    }
    
    private struct PersonJSON {
        var name: String
    }
    
    func testSetIfNeeded() {
        let michelle = Person()
        let json = PersonJSON(name: "Michelle")
        
        XCTAssertNotEqual(michelle.name, json.name)
        XCTAssertTrue(setIfNeeded((michelle, \.name), to: (json, \.name)))
        XCTAssertEqual(michelle.name, json.name)
        XCTAssertFalse(setIfNeeded((michelle, \.name), to: (json, \.name)))
    }
    
    func testConfigure() {
        
        let reference = configure(Person()) {
            $0.name = "Michelle"
        }
        
        XCTAssertEqual(reference.name, "Michelle")
        
        var value = PersonJSON(name: "")
        value = configure(value) {
            $0.name = "Scott"
        }
        
        XCTAssertEqual(value.name, "Scott")
    }
}
