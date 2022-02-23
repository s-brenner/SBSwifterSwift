import XCTest
@testable import SBSwifterSwift

final class DateComponentsExtensionsTests: XCTestCase {
    
    func testComponentDictionary() {
        XCTAssertEqual(DateComponents().componentDictionary, [:])
        XCTAssertEqual(DateComponents(year: 2019, month: 6, day: 29).componentDictionary,
                       [.year : 2019, .month : 6, .day: 29])
    }
    
    func testDuration() {
        XCTAssertEqual(DateComponents().duration, 0)
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
    
    func testAddition() {
        XCTAssertEqual(DateComponents(hour: 4) + DateComponents(minute: 15), DateComponents(hour: 4, minute: 15))
    }
    
    func testSubtraction() {
        XCTAssertEqual(DateComponents(hour: 4) - DateComponents(minute: 15), DateComponents(hour: 4, minute: -15))
    }
    
    func testSubscription() {
        let components = DateComponents(calendar: .current,
                                        timeZone: .current,
                                        era: 1,
                                        year: 1,
                                        month: 1,
                                        day: 1,
                                        hour: 1,
                                        minute: 1,
                                        second: 1,
                                        nanosecond: 1,
                                        weekday: 1,
                                        weekdayOrdinal: 1,
                                        quarter: 1,
                                        weekOfMonth: 1,
                                        weekOfYear: 1,
                                        yearForWeekOfYear: 1)
        XCTAssertEqual(components[.era], 1)
        XCTAssertEqual(components[.year], 1)
        XCTAssertEqual(components[.month], 1)
        XCTAssertEqual(components[.day], 1)
        XCTAssertEqual(components[.hour], 1)
        XCTAssertEqual(components[.minute], 1)
        XCTAssertEqual(components[.second], 1)
        XCTAssertEqual(components[.weekday], 1)
        XCTAssertEqual(components[.weekdayOrdinal], 1)
        XCTAssertEqual(components[.quarter], 1)
        XCTAssertEqual(components[.weekOfMonth], 1)
        XCTAssertEqual(components[.weekOfYear], 1)
        XCTAssertEqual(components[.yearForWeekOfYear], 1)
        XCTAssertEqual(components[.nanosecond], 1)
        XCTAssertNil(components[.calendar])
        XCTAssertNil(components[.timeZone])
    }
    
    func testComparable() {
        XCTAssertTrue(DateComponents(second: 10) > DateComponents(nanosecond: 10))
    }
}
