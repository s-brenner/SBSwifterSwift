#if canImport(SwiftUI) && os(iOS)
import SwiftUI

extension PreviewDevice {
    
    /// iPad (10th generation)
    public static let iPad = PreviewDevice(rawValue: "iPad (10th generation)")
    
    /// iPad Air (5th generation)
    public static let iPadAir = PreviewDevice(rawValue: "iPad Air (5th generation)")
    
    /// iPad Pro (11-inch) (4th generation)
    public static let iPadPro_11inch = PreviewDevice(rawValue: "iPad Pro (11-inch) (4th generation)")
    
    /// iPad Pro (12.9-inch) (6th generation)
    public static let iPadPro_129inch = PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)")
    
    /// iPad mini (6th generation)
    public static let iPadMini = PreviewDevice(rawValue: "iPad mini (6th generation)")
    
    /// iPhone 14
    public static let iPhone14 = PreviewDevice(rawValue: "iPhone 14")
    
    /// iPhone 14 Plus
    public static let iPhone14Plus = PreviewDevice(rawValue: "iPhone 14 Plus")
    
    /// iPhone 14 Pro
    public static let iPhone14Pro = PreviewDevice(rawValue: "iPhone 14 Pro")
    
    /// iPhone 14 Pro Max
    public static let iPhone14ProMax = PreviewDevice(rawValue: "iPhone 14 Pro Max")
    
    /// iPhone SE (3rd generation)
    public static let iPhoneSE3rdGen = PreviewDevice(rawValue: "iPhone SE (3rd generation)")
}

extension Collection where Element == PreviewDevice {
    
    public static var iPads: [PreviewDevice] { [.iPad, .iPadAir, .iPadPro_11inch, .iPadPro_129inch, .iPadMini] }
    
    public static var iPhones: [PreviewDevice] { [.iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax, .iPhoneSE3rdGen] }
}
#endif
