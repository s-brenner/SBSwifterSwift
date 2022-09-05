#if canImport(EventKit)
import EventKit

extension EKAuthorizationStatus: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .authorized: return "Authorized"
        case .denied: return "Denied"
        case .notDetermined: return "Not Determined"
        case .restricted: return "Restricted"
        @unknown default: return "Unknown"
        }
    }
}
#endif
