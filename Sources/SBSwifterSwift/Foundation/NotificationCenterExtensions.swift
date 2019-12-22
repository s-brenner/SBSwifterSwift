#if canImport(UIKit) && canImport(Combine)

import UIKit
import Combine

extension NotificationCenter {
    
    @available(iOS 13.0, *)
    @discardableResult
    public func keyboardNotificationSink(
        _ events: [UIResponder.KeyboardNotification.Event] = [.willShow, .willHide],
        receiveValue: @escaping (UIResponder.KeyboardNotification) -> Void) -> AnyCancellable {

        let publishers = events.map() { publisher(for: $0.name) }

        return Publishers.MergeMany(publishers).compactMap { UIResponder.KeyboardNotification($0) }
            .receive(on: RunLoop.main)
            .sink(receiveValue: receiveValue)
    }
}

#endif
