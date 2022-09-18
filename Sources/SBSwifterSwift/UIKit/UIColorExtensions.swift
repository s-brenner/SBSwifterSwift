#if canImport(UIKit) && os(iOS)
import UIKit

extension UIColor {
    
    public struct Pair {
        
        public var light: UIColor?
        
        public var dark: UIColor?
        
        public init(light: UIColor?, dark: UIColor?) {
            self.light = light
            self.dark = dark
        }
        
        @available(iOS 13.0, *)
        public var color: UIColor? {
            UIColor.colorPair(light: light, dark: dark)
        }
    }
    
    @available(iOS 13.0, *)
    public static func colorPair(light: UIColor?, dark: UIColor?) -> UIColor? {
        
        let randomColor = UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: .random(in: 0...1)
        )
        
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
    
    public static func == (lhs: UIColor, rhs: UIColor) -> Bool {
        
      var r1: CGFloat = 0
      var g1: CGFloat = 0
      var b1: CGFloat = 0
      var a1: CGFloat = 0
      lhs.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        
      var r2: CGFloat = 0
      var g2: CGFloat = 0
      var b2: CGFloat = 0
      var a2: CGFloat = 0
      rhs.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
      return r1 == r2 && g1 == g2 && b1 == b2 && a1 == a2
    }
    
    public func lighter(by percentage: CGFloat = 30.0) -> UIColor {
        adjust(by: abs(percentage))
    }
    
    public func darker(by percentage: CGFloat = 30.0) -> UIColor {
        adjust(by: -1 * abs(percentage))
    }
    
    public func adjust(by percentage: CGFloat = 30.0) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(
                red: min(red + percentage/100, 1.0),
                green: min(green + percentage/100, 1.0),
                blue: min(blue + percentage/100, 1.0),
                alpha: alpha
            )
        } else {
            return self
        }
    }
}
#endif
