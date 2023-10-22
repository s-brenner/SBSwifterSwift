#if os(iOS) || os(macOS) || os(watchOS)
import Foundation

extension Calendar.Component {
    
    /// Return a description of the calendar component in seconds.
    ///
    /// The values for `era`,`weekday`,`weekdayOrdinal`, `yearForWeekOfYear`, `calendar`, `timezone` are `nil`.
    ///
    /// The values for `weekOfYear` and `weekOfMonth` are identical.
    public var timeInterval: TimeInterval? {
        switch self {
        case .era:                      return nil
        case .year:                     return (Calendar.Component.day.timeInterval! * 365.0)
        case .month:                    return (Calendar.Component.minute.timeInterval! * 43800)
        case .day:                      return 86400
        case .hour:                     return 3600
        case .minute:                   return 60
        case .second:                   return 1
        case .quarter:                  return (Calendar.Component.day.timeInterval! * 91.25)
        case .weekOfMonth, .weekOfYear: return (Calendar.Component.day.timeInterval! * 7)
        case .nanosecond:               return 1e-9
        case .timeZone:                 return nil
        case .calendar:                 return nil
        case .weekday:                  return nil
        case .weekdayOrdinal:           return nil
        case .yearForWeekOfYear:        return nil
        @unknown default:               return nil
        }
    }
}
#endif
