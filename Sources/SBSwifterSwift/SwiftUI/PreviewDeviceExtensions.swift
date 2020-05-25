#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public extension PreviewDevice {
    
    static let iPhone8 = PreviewDevice(rawValue: "iPhone 8")
    
    static let iPhone11 = PreviewDevice(rawValue: "iPhone 11")
    
    static let iPhone11ProMax = PreviewDevice(rawValue: "iPhone 11 Pro Max")
    
    static let iPhoneSE2ndGen = PreviewDevice(rawValue: "iPhone SE (2nd generation)")
}
#endif
