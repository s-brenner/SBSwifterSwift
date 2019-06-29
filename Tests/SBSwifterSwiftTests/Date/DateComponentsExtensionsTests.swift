import XCTest
@testable import SBSwifterSwift

final class DateComponentsExtensionsTests: XCTestCase {
    
    func testComponentDictionary() {
        XCTAssertEqual(DateComponents().componentDictionary, [:])
        XCTAssertEqual(DateComponents(year: 2019, month: 6, day: 29).componentDictionary,
                       [.year : 2019, .month : 6, .day: 29])
    }
    
    func testDuration() {
        XCTAssertNil(DateComponents().duration)
        XCTAssertEqual(DateComponents(nanosecond: 1).duration, 0.000000001)
        XCTAssertEqual(DateComponents(second: 1).duration, 1)
        XCTAssertEqual(DateComponents(minute: 1).duration, 60)
        XCTAssertEqual(DateComponents(hour: 1).duration, 3600)
        XCTAssertEqual(DateComponents(day: 1).duration, 86400)
    }
    
    func testIsLeapYear() {
        
        // Test errors
        XCTAssertThrowsError(try DateComponents().isLeapYear())
        XCTAssertThrowsError(try DateComponents(year: -1).isLeapYear())
        
        // Test known leap years from 2000 to 2096
        (0...24).forEach() {
            let year = 2000 + $0 * 4
            XCTAssertTrue(try! DateComponents(year: year).isLeapYear(), "\(year) is not a leap year.")
        }
        
        // Test the beginning of centuries
        XCTAssertFalse(try! DateComponents(year: 2100).isLeapYear())
        XCTAssertFalse(try! DateComponents(year: 2200).isLeapYear())
        XCTAssertFalse(try! DateComponents(year: 2300).isLeapYear())
        XCTAssertTrue(try! DateComponents(year: 2400).isLeapYear())
        
        // Test known non-leap years
        XCTAssertFalse(try! DateComponents(year: 2021).isLeapYear())
        XCTAssertFalse(try! DateComponents(year: 2022).isLeapYear())
        XCTAssertFalse(try! DateComponents(year: 2023).isLeapYear())
    }
    
    func testNegation() {
        let dateComponents1 = DateComponents(year: 2019, month: 6)
        let dateComponents2 = DateComponents(year: -2019, month: -6)
        XCTAssertEqual(-dateComponents1, dateComponents2)
    }
    
    func testComparable() {
        XCTAssertTrue(DateComponents(second: 10) > DateComponents(nanosecond: 10))
    }
}
