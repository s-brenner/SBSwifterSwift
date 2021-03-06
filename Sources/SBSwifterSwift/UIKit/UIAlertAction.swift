#if canImport(UIKit)
import UIKit

extension UIAlertAction {
    
    public static func ok(handler: (() -> Void)? = nil) -> UIAlertAction {
        .init(title: "OK", style: .default) { _ in
            handler?()
        }
    }
}
#endif
