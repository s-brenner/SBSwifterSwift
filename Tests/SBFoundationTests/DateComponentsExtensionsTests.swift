import XCTest
@testable import SBSwifterSwift

final class DateComponentsExtensionsTests: XCTestCase {
    
    func testDuration() {
        XCTAssertEqual(DateComponents().duration, 0)
        XCTAssertEqual(DateComponents(nanosecond: 1).duration, 0.000000001)
        XCTAssertEqual(DateComponents(second: 1).duration, 1)
        XCTAssertEqual(DateComponents(minute: 1).duration, 60)
        XCTAssertEqual(DateComponents(hour: 1).duration, 3600)
        XCTAssertEqual(DateComponents(day: 1).duration, 86400)
    }
    
    func testSubscription() {
        let components = DateComponents(
            calendar: .current,
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
            yearForWeekOfYear: 1
        )
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
    
    func testToString() {
        let dateComponents = DateComponents(day: 1, hour: 0, minute: 12)
        XCTAssertEqual(dateComponents.toString(withConfiguration: .dayHourMinute), "1d 0h 12m")
        XCTAssertEqual(dateComponents.toString(), "1d 0h 12m")
    }
    
    func testComparable() {
        XCTAssertTrue(DateComponents(second: 10) > DateComponents(nanosecond: 10))
    }
}
