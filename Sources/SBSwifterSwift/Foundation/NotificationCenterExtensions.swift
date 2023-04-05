#if canImport(UIKit) && canImport(Combine) && os(iOS)
import UIKit
import Combine

extension NotificationCenter {

    /// Returns a publisher that emits events whenever the selected keyboard events occur.
    /// - Parameter events: The keyboard events that cause the publisher to emit. Defaults to `willShow` and `willHide`.
    public func keyboardPublisher(
        forEvents events: [UIResponder.KeyboardNotification.Event] = [.willShow, .willHide]
    ) -> AnyPublisher<UIResponder.KeyboardNotification, Never> {
        Publishers.MergeMany(events.map { publisher(for: $0.name) })
            .compactMap { UIResponder.KeyboardNotification($0) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
#endif
