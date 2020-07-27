#if canImport(UIKit)
import UIKit

public extension UITextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        publisher(for: .editingChanged)
            .map { self.text ?? "" }
            .eraseToAnyPublisher()
    }
}
#endif
