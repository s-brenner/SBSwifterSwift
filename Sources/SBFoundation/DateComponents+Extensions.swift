#if os(iOS) || os(macOS) || os(watchOS)
extension DateComponents {
    
    /// Nanoseconds, seconds, minutes, hours, and days converted to seconds.
    public var duration: TimeInterval {
        var timeInterval: TimeInterval = 0
        timeInterval += TimeInterval(nanosecond ?? 0) / 1_000_000_000
        timeInterval += TimeInterval(second ?? 0)
        timeInterval += TimeInterval(minute ?? 0) * 60
        timeInterval += TimeInterval(hour ?? 0) * 3600
        timeInterval += TimeInterval(day ?? 0) * 86400
        return timeInterval
    }
    
    /// Subscription support for `DateComponents` instances.
    /// ````
    /// let components = DateComponents(day: 5)
    /// components[.day]
    /// // 5
    /// ````
    /// - Important: This does not take into account any built-in errors, `Int.max` returned instead of `nil`.
    /// - Parameter component: Component to get.
    public subscript(component: Calendar.Component) -> Int? {
        switch component {
        case .era: return era
        case .year: return year
        case .month: return month
        case .day: return day
        case .hour: return hour
        case .minute: return minute
        case .second: return second
        case .weekday: return weekday
        case .weekdayOrdinal: return weekdayOrdinal
        case .quarter: return quarter
        case .weekOfMonth: return weekOfMonth
        case .weekOfYear: return weekOfYear
        case .yearForWeekOfYear: return yearForWeekOfYear
        case .nanosecond: return nanosecond
        case .calendar: return nil
        case .timeZone: return nil
        case .isLeapMonth: return nil
        @unknown default: return nil
        }
    }
    
    /// Convert receiver to a string with the given configuration.
    /// - Parameter configuration:A configuration for the formatter that will perform the transformation.
//    public func toString(withConfiguration configuration: DateComponentsFormatter.Configuration = .dayHourMinute) -> String? {
//        DateComponentsFormatter
//            .sharedFormatter(withConfiguration: configuration)
//            .string(from: self)
//    }
}

extension DateComponents: Comparable {
    
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        lhs.duration < rhs.duration
    }
}
#endif
