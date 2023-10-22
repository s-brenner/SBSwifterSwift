import XCTest
@testable import SBSwifterSwift

final class CalendarComponentExtensionsTests: XCTestCase {
    
    // MARK: - Tests
    
    func testTimeInterval() {
        
        XCTAssertNil(Calendar.Component.era.timeInterval)
        XCTAssertNil(Calendar.Component.weekday.timeInterval)
        XCTAssertNil(Calendar.Component.weekdayOrdinal.timeInterval)
        XCTAssertNil(Calendar.Component.yearForWeekOfYear.timeInterval)
        XCTAssertNil(Calendar.Component.calendar.timeInterval)
        XCTAssertNil(Calendar.Component.timeZone.timeInterval)
        
        XCTAssertEqual(Calendar.Component.weekOfYear.timeInterval, Calendar.Component.weekOfMonth.timeInterval)
        
        XCTAssertEqual(Calendar.Component.year.timeInterval, 31_536_000)
        XCTAssertEqual(Calendar.Component.month.timeInterval, 2_628_000)
        XCTAssertEqual(Calendar.Component.day.timeInterval, 86_400)
        XCTAssertEqual(Calendar.Component.hour.timeInterval, 3_600)
        XCTAssertEqual(Calendar.Component.minute.timeInterval, 60)
        XCTAssertEqual(Calendar.Component.second.timeInterval, 1)
        XCTAssertEqual(Calendar.Component.quarter.timeInterval, 7_884_000)
        XCTAssertEqual(Calendar.Component.weekOfMonth.timeInterval, 604_800)
        XCTAssertEqual(Calendar.Component.weekOfYear.timeInterval, 604_800)
        XCTAssertEqual(Calendar.Component.nanosecond.timeInterval, 1e-9)
    }
}
