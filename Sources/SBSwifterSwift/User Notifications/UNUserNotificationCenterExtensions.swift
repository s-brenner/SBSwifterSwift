import UserNotifications

public extension UNUserNotificationCenter {
    
    var pendingNotificationRequestsPublisher: AnyPublisher<[UNNotificationRequest], Never> {
        Future<[UNNotificationRequest], Never> { [weak self] promise in
            self?.getPendingNotificationRequests {
                promise(.success($0))
            }
        }
        .eraseToAnyPublisher()
    }
    
    var deliveredNotificationsPublisher: AnyPublisher<[UNNotification], Never> {
        Future<[UNNotification], Never> { [weak self] promise in
            self?.getDeliveredNotifications {
                promise(.success($0))
            }
        }
        .eraseToAnyPublisher()
    }
}
