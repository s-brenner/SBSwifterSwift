#if canImport(UserNotifications)
import UserNotifications

extension UNNotificationRequest {
    
    public func add(to center: UNUserNotificationCenter = .current()) -> AnyPublisher<Void, UNError> {
        Future<Void, UNError> { promise in
            center.add(self) { error in
                if let error = error as? UNError {
                    promise(.failure(error))
                }
                else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}


extension Sequence where Element == UNNotificationRequest {
    
    public func add(to center: UNUserNotificationCenter = .current()) -> AnyPublisher<Void, UNError> {
        Publishers
            .Sequence<[AnyPublisher<Void, UNError>], UNError>(sequence: map { $0.add(to: center) })
            .flatMap { $0 }
            .eraseToAnyPublisher()
    }
}
#endif
