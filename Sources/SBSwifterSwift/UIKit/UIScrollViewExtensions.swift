#if canImport(UIKit) && canImport(Combine)
import UIKit
import Combine

extension UIScrollView {
    
    /// Adjust the content inset and scroll indicator inset when the keyboard shows or hides.
    @available(iOS 13.0, *)
    public var keyboardPublisher: AnyCancellable {
        
        let keyboardWillOpen = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .map { $0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect }
            .map { [unowned self] in $0.height - (self.superview?.safeAreaInsets.bottom ?? 0) }

        let keyboardWillHide =  NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        return Publishers.Merge(keyboardWillOpen, keyboardWillHide)
            .subscribe(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] in
                self.contentInset.bottom = $0
                self.verticalScrollIndicatorInsets.bottom = $0
            })
    }
}
#endif
