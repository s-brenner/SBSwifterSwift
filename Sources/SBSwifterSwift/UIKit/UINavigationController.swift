#if canImport(UIKit)
import UIKit

extension UINavigationController {
    
    /// The view controller located at index n-2, where n is the number of view controllers on the stack.
    public var backViewController: UIViewController? {
        
        let index = viewControllers.count - 2
        return index >= 0 ? viewControllers[index] : nil
    }
    
    /// The view controller located at index 0 in the array of view controllers.
    public var rootViewController: UIViewController? {
        
        viewControllers.isEmpty ? nil : viewControllers[0]
    }
}
#endif
