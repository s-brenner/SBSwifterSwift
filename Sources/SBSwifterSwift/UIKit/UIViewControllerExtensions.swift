#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIViewController {
    
    /// Check if ViewController is onscreen and not hidden.
    var isVisible: Bool {
        
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        
        isViewLoaded && view.window != nil
    }
    
    /// SwifterSwift: Assign as listener to notification.
    /// - Parameter name: Notification name.
    /// - Parameter selector: Selector to run when notified.
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    /// Assign observer as listener to keyboard notification.
    /// - Parameters:
    ///   - observer: Object registering as an observer.
    ///   - selector: Selector to run when notified.
    ///   - events: Keyboard events to listen for.
    func addKeyboardObserver(
        _ observer: Any,
        selector: Selector,
        events: Set<UIResponder.KeyboardNotification.Event> = [.willShow, .willHide]) {
        
        events.forEach() {
            NotificationCenter.default.addObserver(observer, selector: selector, name: $0.name, object: nil)
        }
    }
    
    /// Unassign as listener to notification.
    /// - Parameter name: Notification name.
    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    /// Unassign as listener from all notifications.
    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// Adds the specified view controller as a child of the current view controller.
    /// - Parameter child: The view controller to be added as a child.
    /// - Returns: The child view controller.
    @discardableResult
    func add(_ child: UIViewController) -> UIViewController {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        return child
    }
    
    /// Removes the view controller from its parent.
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    /// Create a new instance of a view controller to present programmatically.
    /// - Parameter type: The type of view controller to instantiate.
    /// - Parameter storyboard: The storyboard from which to instantiate the view controller.
    static func instantiate<T: UIViewController>(_ type: T.Type, storyboard: UIStoryboard = .main) -> T {
        guard let vc = storyboard.instantiateViewController(withIdentifier: String(describing: type)) as? T else {
            fatalError("Couldn't instantiate \(type)")
        }
        return vc
    }
    
    func replaceViews(_ oldViews: UIView?..., with newView: UIView, animated: Bool) {
        
        let animationDuration = animated ? 0.3 : 0.0
        guard !view.subviews.contains(newView) else { return }

        oldViews.forEach() {
            $0?.fadeTransition(duration: animationDuration)
            $0?.removeFromSuperview()
        }

        view.fadeTransition(duration: animationDuration)
        view.addSubview(newView)
    }
}


extension UIViewController {
    
    @objc open func handle(_ error: Error, retryHandler: @escaping () -> Void) {
        
        handle(error, from: self, retryHandler: retryHandler)
    }
}
#endif
