import Foundation

extension DateComponents
{
    // MARK: - Types
    
    public enum Error: LocalizedError {
        case yearIsUndefined
        case yearIsNegative
        
        public var errorDescription: String? {
            switch self {
            case .yearIsUndefined: return "The year is undefined."
            case .yearIsNegative: return "The year is negative."
            }
        }
    }
    
    
    // MARK: - Properties
    
    /// Set of components.
    public static let allComponentsSet: Set<Calendar.Component> = [
        .era,
        .year,
        .month,
        .day,
        .hour,
        .minute,
        .second,
        .weekday,
        .weekdayOrdinal,
        .quarter,
        .weekOfMonth,
        .weekOfYear,
        .yearForWeekOfYear,
        .nanosecond,
        .calendar,
        .timeZone
    ]
    
    /// Array of components in ascending order.
    static let allComponents: [Calendar.Component] =  [
        .nanosecond,
        .second,
        .minute,
        .hour,
        .day,
        .month,
        .year,
        .yearForWeekOfYear,
        .weekOfYear,
        .weekday,
        .quarter,
        .weekdayOrdinal,
        .weekOfMonth
    ]
    
    /// A dictionary containing only those components that are not `nil`.
    public var componentDictionary: [Calendar.Component : Int] {
        var list: [Calendar.Component : Int] = [:]
        DateComponents.allComponents.forEach { component in
            let value = self.value(for: component)
            if value != nil && value != Int(NSDateComponentUndefined) {
                list[component] = value!
            }
        }
        return list
    }
    
    /// Nanoseconds, seconds, minutes, hours, and days converted to seconds.
    ///
    /// Will return `nil` if all of the relevant fields are `nil`.
    public var duration: TimeInterval? {
        if nanosecond == nil && second == nil && minute == nil && hour == nil && day == nil { return nil }
        var timeInterval: TimeInterval = 0
        if let nanosecond = nanosecond { timeInterval += TimeInterval(nanosecond) / 1_000_000_000 }
        if let second = second { timeInterval += TimeInterval(second) }
        if let minute = minute { timeInterval += TimeInterval(minute) * 60 }
        if let hour = hour { timeInterval += TimeInterval(hour) * 3600 }
        if let day = day { timeInterval += TimeInterval(day) * 86400 }
        return timeInterval
    }
    
    
    // MARK: - Public methods
    
    /// Returns whether or not the year is a leap year.
    public func isLeapYear() throws -> Bool {
        guard let year = year else { throw Error.yearIsUndefined }
        guard year >= 0 else { throw Error.yearIsNegative }
        if year % 400 == 0 { return true }
        else if year % 100 == 0 { return false }
        else if year % 4 == 0 { return true }
        return false
    }
    
    /// Flip the sign of all values that are not `NSDateComponentUndefined`.
    public static prefix func - (rhs: DateComponents) -> DateComponents {
        var components = DateComponents()
        components.era = rhs.era.map(-)
        components.year = rhs.year.map(-)
        components.month = rhs.month.map(-)
        components.day = rhs.day.map(-)
        components.hour = rhs.hour.map(-)
        components.minute = rhs.minute.map(-)
        components.second = rhs.second.map(-)
        components.nanosecond = rhs.nanosecond.map(-)
        components.weekday = rhs.weekday.map(-)
        components.weekdayOrdinal = rhs.weekdayOrdinal.map(-)
        components.quarter = rhs.quarter.map(-)
        components.weekOfMonth = rhs.weekOfMonth.map(-)
        components.weekOfYear = rhs.weekOfYear.map(-)
        components.yearForWeekOfYear = rhs.yearForWeekOfYear.map(-)
        return components
    }
}


extension DateComponents: Comparable {
    
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        guard let lhsDuration = lhs.duration,
            let rhsDuration = rhs.duration
            else { fatalError("Unable to compare \(lhs) to \(rhs)") }
        return lhsDuration < rhsDuration
    }
}
