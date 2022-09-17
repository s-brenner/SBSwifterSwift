#if canImport(UserNotifications)
import UserNotifications

extension Sequence where Element == UNNotificationRequest {
    
    public func add(to center: UNUserNotificationCenter = .current()) async throws {
        try await asyncForEach { request in
            try await center.add(request)
        }
    }
}
#endif
