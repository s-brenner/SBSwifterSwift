import Darwin
import CoreGraphics

extension Double {
    
    /// Int.
    public var int: Int { Int(self) }
    
    /// Float.
    public var float: Float { Float(self) }
    
    /// CGFloat.
    public var cgFloat: CGFloat { CGFloat(self) }
}
