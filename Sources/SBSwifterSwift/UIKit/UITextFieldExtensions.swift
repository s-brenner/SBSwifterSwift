#if canImport(UIKit) && os(iOS)
import UIKit

extension UITextField {
    
    public var textPublisher: AnyPublisher<String, Never> {
        publisher(for: .editingChanged)
            .map { self.text ?? "" }
            .eraseToAnyPublisher()
    }
}
#endif
