#if canImport(UIKit)
import UIKit

public extension UIButton {
    
    /// Sets the background color to use for the specified state.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter color: The color to use for the background.
    /// - Parameter state: The state that uses the specified background color.
    func setBackgroundColor(_ color: UIColor, forState state: UIControl.State) {

      let minimumSize: CGSize = CGSize(width: 1.0, height: 1.0)

      UIGraphicsBeginImageContext(minimumSize)

      if let context = UIGraphicsGetCurrentContext() {
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: .zero, size: minimumSize))
      }

      let colorImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      self.clipsToBounds = true
      self.setBackgroundImage(colorImage, for: state)
    }
}
#endif
