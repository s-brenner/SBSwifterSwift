extension RelativeDateTimeFormatter {
    
    /// Return the local thread shared relative date time formatter for a given
    /// dateTimeStyle, formattingContext, unitsStyle, calendar and locale.
    /// - Parameters:
    ///   - dateTimeStyle: The date time style of the returned formatter.
    ///   - formattingContext: The formatting context of the returned formatter.
    ///   - unitsStyle: The units style of the returned formatter.
    ///   - calendar: The calendar of the returned formatter.
    ///   - locale: The locale of the returned formatter.
    public static func shared(
        dateTimeStyle: DateTimeStyle,
        formattingContext: Formatter.Context,
        unitsStyle: UnitsStyle,
        calendar: Calendar = .current,
        locale: Locale = .current
    ) -> RelativeDateTimeFormatter {
        let name = "SBFoundation.\(String(describing: RelativeDateTimeFormatter.self))" +
            ".dateTimeStyle=\(dateTimeStyle.rawValue)" +
            ".formattingContext=\(formattingContext.rawValue)" +
            ".unitsStyle=\(unitsStyle.rawValue)" +
            ".calendar=\(calendar.description)" +
            ".locale=\(locale.description)"
        let formatter: RelativeDateTimeFormatter = threadSharedObject(key: name) {
            let formatter = RelativeDateTimeFormatter()
            formatter.dateTimeStyle = dateTimeStyle
            formatter.formattingContext = formattingContext
            formatter.unitsStyle = unitsStyle
            formatter.calendar = calendar
            formatter.locale = locale
            return formatter
        }
        return formatter
    }
}
