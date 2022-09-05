#if canImport(UserNotifications)
import UserNotifications

extension UNAuthorizationStatus: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .authorized: return "Authorized"
        case .denied: return "Denied"
        case .notDetermined: return "Not Determined"
        case .ephemeral: return "Ephemeral"
        case .provisional: return "Provisional"
        @unknown default: return "Unknown"
        }
    }
}
#endif
