#if canImport(UserNotifications)
import UserNotifications

public extension UNNotificationRequest {
    
    func add(to center: UNUserNotificationCenter = .current()) -> AnyPublisher<Void, UNError> {
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


public extension Sequence where Element == UNNotificationRequest {
    
    func add(to center: UNUserNotificationCenter = .current()) -> AnyPublisher<Void, UNError> {
        Publishers
            .Sequence<[AnyPublisher<Void, UNError>], UNError>(sequence: map { $0.add(to: center) })
            .flatMap { $0 }
            .eraseToAnyPublisher()
    }
}
#endif
