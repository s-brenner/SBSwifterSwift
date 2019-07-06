import Darwin
import CoreGraphics

extension Double {
    
    /// Float.
    public var float: Float { Float(self) }
    
    /// CGFloat.
    public var cgFloat: CGFloat { CGFloat(self) }
}
