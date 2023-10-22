import XCTest
@testable import SBSwifterSwift

@available(iOS 13.0, OSX 10.15, tvOS 13.0, *)
final class RelativeDateTimeFormatterExtensionsTests: XCTestCase {
    
    func testFormatter() {
        let formatter = RelativeDateTimeFormatter.shared(
            dateTimeStyle: .numeric,
            formattingContext: .standalone,
            unitsStyle: .full,
            calendar: Calendar(identifier: .gregorian),
            locale: .autoupdatingCurrent
        )
        XCTAssertEqual(formatter.dateTimeStyle, .numeric)
        XCTAssertEqual(formatter.formattingContext, .standalone)
        XCTAssertEqual(formatter.unitsStyle, .full)
        XCTAssertEqual(formatter.calendar.identifier, Calendar.Identifier.gregorian)
        XCTAssertEqual(formatter.locale, .autoupdatingCurrent)
        XCTAssertEqual(formatter.localizedString(from: DateComponents(day: 1)), "in 1 day")
    }
}
