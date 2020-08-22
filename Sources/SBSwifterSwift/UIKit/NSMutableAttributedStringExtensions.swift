#if canImport(UIKit)
import UIKit

public extension NSMutableAttributedString {
    
    var range: NSRange { NSRange(0..<string.count) }
    
    func font(_ font: UIFont) -> Self {
        addAttribute(.font, value: font, range: range)
        return self
    }
    
    func font(_ style: UIFont.TextStyle) -> Self {
        self.font(.preferredFont(forTextStyle: style))
    }
    
    func foregroundColor(_ color: UIColor) -> Self {
        addAttribute(.foregroundColor, value: color, range: range)
        return self
    }
    
    func link(_ urlString: String) -> Self {
        addAttribute(.link, value: urlString, range: range)
        return self
    }
    
    func strikethrough(color: UIColor, style: NSUnderlineStyle) -> Self {
        addAttributes([.strikethroughColor: color, .strikethroughStyle: style.rawValue], range: range)
        return self
    }
    
    func underline(color: UIColor, style: NSUnderlineStyle) -> Self {
        addAttributes([.underlineColor: color, .underlineStyle: style.rawValue], range: range)
        return self
    }
}
#endif
