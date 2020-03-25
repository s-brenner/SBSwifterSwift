#if canImport(UIKit)
import UIKit

extension UIColor {
    
    @available(iOS 13.0, *)
    public static func colorPair(light: UIColor?, dark: UIColor?) -> UIColor? {
        
        let randomColor = UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: .random(in: 0...1))
        
        let desiredColor = UIColor { traitCollection -> UIColor in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return dark ?? randomColor
                
            case .light, .unspecified:
                return light ?? randomColor
                
            @unknown default:
                return light ?? randomColor
            }
        }
        
        return desiredColor == randomColor ? nil : desiredColor
    }
    
    public static func == (l: UIColor, r: UIColor) -> Bool {
        
      var r1: CGFloat = 0
      var g1: CGFloat = 0
      var b1: CGFloat = 0
      var a1: CGFloat = 0
      l.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        
      var r2: CGFloat = 0
      var g2: CGFloat = 0
      var b2: CGFloat = 0
      var a2: CGFloat = 0
      r.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
      return r1 == r2 && g1 == g2 && b1 == b2 && a1 == a2
    }
}
#endif
