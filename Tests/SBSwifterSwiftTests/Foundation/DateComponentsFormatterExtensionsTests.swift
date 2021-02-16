import XCTest
@testable import SBSwifterSwift

final class DateComponentsFormatterExtensionsTests: XCTestCase {
    
    func testSharedFormatter() {
        var formatter = DateComponentsFormatter.sharedFormatter(withConfiguration: .dayHourMinute)
        XCTAssertEqual(formatter.string(from: DateComponents(day: 1, hour: 0, minute: 12)), "1d 0h 12m")
        XCTAssertEqual(formatter.string(from: DateComponents(hour: 4, minute: 12)), "0d 4h 12m")
        
        formatter = DateComponentsFormatter.sharedFormatter {
            $0.allowedUnits = [.day]
        }
        XCTAssertEqual(formatter.string(from: DateComponents(day: 1, hour: 0, minute: 12)), "1d")
        XCTAssertEqual(formatter.string(from: DateComponents(hour: 4, minute: 12)), "0d")
    }
}
