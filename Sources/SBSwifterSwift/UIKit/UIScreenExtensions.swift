#if canImport(UIKit)
import UIKit

@available(iOS 13.0, *)
public extension UIScreen {
    
    enum Device {
        case iPhone6s
        case iPhone6sPlus
        case iPhoneSE_Generation1
        case iPhoneSE_Generation2
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
            case .iPhone11Pro, .iPhoneXS, .iPhoneX, .iPhone8, .iPhone7, .iPhone6s, .iPhoneSE_Generation2:
                return 375
                
            case .iPhone11ProMax, .iPhoneXSMax, .iPhone11, .iPhoneXR, .iPhone8Plus, .iPhone7Plus, .iPhone6sPlus:
                return 414
                
            case .iPhoneSE_Generation1:
                return 320
            }
        }
        
        var screenHeight: CGFloat {
            switch self {
            case .iPhone11ProMax, .iPhoneXSMax, .iPhone11, .iPhoneXR:
                return 896
                
            case .iPhone11Pro, .iPhoneX, .iPhoneXS:
                return 812
                
            case .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus:
                return 736
                
            case .iPhone6s, .iPhone7, .iPhone8, .iPhoneSE_Generation2:
                return 667
            
            case .iPhoneSE_Generation1:
                return 568
            }
        }
    }
    
    func isWiderThan(_ device: Device) -> Bool {
        
        bounds.width > device.screenWidth
    }
    
    func isTallerThan(_ device: Device) -> Bool {
        
        bounds.height > device.screenHeight
    }
}

#endif
