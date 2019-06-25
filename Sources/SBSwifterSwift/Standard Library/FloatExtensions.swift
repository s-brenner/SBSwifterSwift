import Darwin
import CoreGraphics

extension Float {
    
    /// Int.
    public var int: Int { Int(self) }
    
    /// Double.
    public var double: Double { Double(self) }

    /// CGFloat.
    public var cgFloat: CGFloat { CGFloat(self) }
}
