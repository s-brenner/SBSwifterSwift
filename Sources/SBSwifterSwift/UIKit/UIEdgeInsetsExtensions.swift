//#if canImport(UIKit)
//import UIKit
//
//extension UIEdgeInsets {
//    
//    /// The inset to use for a scroll view in response to
//    /// - Parameters:
//    ///   - notification: The notification that dictates the return value. Only notifications named `UIResponder.keyboardWillChangeFrameNotification` will return a nonzero inset.
//    ///   - view: The view used to calculate the keyboard height. Normally the scroll view's superview.
//    
//    public static func insetForKeyboardNotification(
//        _ notification: Notification,
//        in view: UIView) -> UIEdgeInsets {
//        
//        switch notification.name {
//        case UIResponder.keyboardWillChangeFrameNotification:
//            guard let userInfo = notification.userInfo,
//                let keyboardFrameEndValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
//                    return .zero
//            }
//            let keyboardFrameEnd = view.convert(keyboardFrameEndValue.cgRectValue, from: view.window)
//            let height = keyboardFrameEnd.height - view.safeAreaInsets.bottom
//            return .init(top: 0, left: 0, bottom: height, right: 0)
//            
//        default:
//            return .zero
//        }
//    }
//}
//#endif
