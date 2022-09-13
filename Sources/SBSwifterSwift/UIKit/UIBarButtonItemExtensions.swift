#if canImport(UIKit) && os(iOS)
import UIKit

extension UIBarButtonItem {
    
    /// A back button whose title is simply "Back".
    public static let back =
    UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    
    public static let spacer =
    UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
}
#endif
