#if canImport(UIKit)
import UIKit

@available(iOS 13.0, *)
public extension UIScreen {
    
    enum Device {
        case iPhone6s
        case iPhone6sPlus
        case iPhoneSE
        case iPhone7
        case iPhone7Plus
        case iPhone8
        case iPhone8Plus
        case iPhoneX
        case iPhoneXR
        case iPhoneXS
        case iPhoneXSMax
        case iPhone11
        case iPhone11Pro
        case iPhone11ProMax
        
        /// Screen width in points.
        var screenWidth: CGFloat {
            // https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
            switch self {
            case .iPhone11Pro, .iPhoneXS, .iPhoneX, .iPhone8, .iPhone7, .iPhone6s:
                return 375
                
            case .iPhone11ProMax, .iPhoneXSMax, .iPhone11, .iPhoneXR, .iPhone8Plus, .iPhone7Plus, .iPhone6sPlus:
                return 414
                
            case .iPhoneSE:
                return 320
            }
        }
    }
    
    func isWiderThan(_ device: Device) -> Bool {
        
        bounds.width > device.screenWidth
    }
}

#endif
