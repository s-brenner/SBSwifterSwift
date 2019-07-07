#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIStoryboard
{
    // MARK: - Properties
    
    public static let main = UIStoryboard(name: "Main", bundle: nil)
}

#endif
