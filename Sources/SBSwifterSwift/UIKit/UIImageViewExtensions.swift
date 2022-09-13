#if canImport(UIKit) && os(iOS)
import UIKit

extension UIImageView {
    
    public func setImage(to image: UIImage?, animate: Bool = true) {
        fadeTransition(duration: animate ? 0.25 : 0)
        self.image = image
    }
}
#endif
