#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIViewController {
    
    // MARK: - Properties
    
    /// Check if ViewController is onscreen and not hidden.
    public var isVisible: Bool {
        
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        
        isViewLoaded && view.window != nil
    }

    
    // MARK: - Methods
    
    /// SwifterSwift: Assign as listener to notification.
    /// - Parameter name: Notification name.
    /// - Parameter selector: Selector to run when notified.
    public func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    /// Unassign as listener to notification.
    /// - Parameter name: Notification name.
    public func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    /// Unassign as listener from all notifications.
    public func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// Adds the specified view controller as a child of the current view controller.
    /// - Parameter child: The view controller to be added as a child.
    /// - Returns: The child view controller.
    @discardableResult
    public func add(_ child: UIViewController) -> UIViewController {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        return child
    }
    
    /// Removes the view controller from its parent.
    public func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    /// Create a new instance of a view controller to present programmatically.
    /// - Parameter type: The type of view controller to instantiate.
    /// - Parameter storyboard: The storyboard from which to instantiate the view controller.
    public static func instantiate<T: UIViewController>(_ type: T.Type, storyboard: UIStoryboard = .main) -> T {
        guard let vc = storyboard.instantiateViewController(withIdentifier: String(describing: type)) as? T else {
            fatalError("Couldn't instantiate \(type)")
        }
        return vc
    }
}

#endif
