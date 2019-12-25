#if canImport(UIKit)
import UIKit

extension UILabel {
    
    public var maximumNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: Float.infinity.cgFloat)
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(
            with: maxSize,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font!],
            context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}
#endif
