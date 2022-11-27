#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public extension PreviewDevice {
    
    static let iPhone14 = PreviewDevice(rawValue: "iPhone 14")
    
    static let iPhone14Plus = PreviewDevice(rawValue: "iPhone 14 Plus")
    
    static let iPhone14Pro = PreviewDevice(rawValue: "iPhone 14 Pro")
    
    static let iPhone14ProMax = PreviewDevice(rawValue: "iPhone 14 Pro Max")
    
    static let iPhoneSE3rdGen = PreviewDevice(rawValue: "iPhone SE (3rd generation)")
}
#endif
