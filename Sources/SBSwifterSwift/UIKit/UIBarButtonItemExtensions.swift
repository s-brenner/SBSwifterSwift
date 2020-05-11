#if canImport(UIKit)
import UIKit

public extension UIBarButtonItem {
    
    /// A back button whose title is simply "Back".
    static let back = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    
    static let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
}
#endif
