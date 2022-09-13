#if canImport(UIKit) && os(iOS)
import UIKit

@available(iOS 13.0, *)
extension UIActivityIndicatorView {
    
    /// A factory method for creating an acitvity indicator view and center anchoring it to a provided view.
    /// - Parameters:
    ///   - view: The view to which the activity indicator view will be center anchored.
    ///   - style: A constant that specifies the style of the acitivity indicator view.
    ///   - hidesWhenStopped: A Boolean value that controls whether the receiver is hidden when the animation is stopped.
    public static func add(
        to view: UIView,
        style: Style = .medium,
        hidesWhenStopped: Bool = true
    ) -> UIActivityIndicatorView {
        let s = UIActivityIndicatorView(style: style)
        s.hidesWhenStopped = hidesWhenStopped
        view.addSubview(s)
        s.anchorCenterToSuperview()
        return s
    }
}
#endif
