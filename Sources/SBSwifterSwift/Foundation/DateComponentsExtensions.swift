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
    
    /// Negates all values that are not `NSDateComponentUndefined`.
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
    
    /// Adds two DateComponents and returns their combined individual components.
    public static func + (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
        combine(lhs, rhs: rhs, transform: +)
    }
    
    /// Subtracts two DateComponents and returns the relative difference between them.
    public static func - (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
        lhs + (-rhs)
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
        case .era:                  return era
        case .year:                 return year
        case .month:                return month
        case .day:                  return day
        case .hour:                 return hour
        case .minute:               return minute
        case .second:               return second
        case .weekday:              return weekday
        case .weekdayOrdinal:       return weekdayOrdinal
        case .quarter:              return quarter
        case .weekOfMonth:          return weekOfMonth
        case .weekOfYear:           return weekOfYear
        case .yearForWeekOfYear:    return yearForWeekOfYear
        case .nanosecond:           return nanosecond
        case .calendar, .timeZone:  return nil
        @unknown default:           return nil
        }
    }
    
    
    // MARK: - Helper methods
    
    /// Applies the `transform` to both `T` values provided, defaulting either of them if `nil`.
    /// - Parameter a: Optional value.
    /// - Parameter b: Optional value.
    /// - Parameter default: The default value to use in the event `a` or `b` are `nil`.
    /// - Parameter transform: The transform to use.
    /// - Returns: The transformed value. If both `T` values are `nil`, returns `nil`.
    private static func bimap<T>(_ a: T?, _ b: T?, default: T, _ transform: (T, T) -> T) -> T? {
        if a == nil && b == nil { return nil }
        return transform(a ?? `default`, b ?? `default`)
    }
    
    /// Combines two date components using the provided `transform` on all values within the components that are not `NSDateComponentUndefined`.
    private static func combine(_ lhs: DateComponents, rhs: DateComponents, transform: (Int, Int) -> Int) -> DateComponents {
        var components = DateComponents()
        components.era = bimap(lhs.era, rhs.era, default: 0, transform)
        components.year = bimap(lhs.year, rhs.year, default: 0, transform)
        components.month = bimap(lhs.month, rhs.month, default: 0, transform)
        components.day = bimap(lhs.day, rhs.day, default: 0, transform)
        components.hour = bimap(lhs.hour, rhs.hour, default: 0, transform)
        components.minute = bimap(lhs.minute, rhs.minute, default: 0, transform)
        components.second = bimap(lhs.second, rhs.second, default: 0, transform)
        components.nanosecond = bimap(lhs.nanosecond, rhs.nanosecond, default: 0, transform)
        components.weekday = bimap(lhs.weekday, rhs.weekday, default: 0, transform)
        components.weekdayOrdinal = bimap(lhs.weekdayOrdinal, rhs.weekdayOrdinal, default: 0, transform)
        components.quarter = bimap(lhs.quarter, rhs.quarter, default: 0, transform)
        components.weekOfMonth = bimap(lhs.weekOfMonth, rhs.weekOfMonth, default: 0, transform)
        components.weekOfYear = bimap(lhs.weekOfYear, rhs.weekOfYear, default: 0, transform)
        components.yearForWeekOfYear = bimap(lhs.yearForWeekOfYear, rhs.yearForWeekOfYear, default: 0, transform)
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
