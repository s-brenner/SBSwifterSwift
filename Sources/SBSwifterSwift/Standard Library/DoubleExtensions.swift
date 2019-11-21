import Darwin
import CoreGraphics

extension Double {
    
    /// Float.
    public var float: Float { Float(self) }
    
    /// CGFloat.
    public var cgFloat: CGFloat { CGFloat(self) }
    
    /// Int. Rounded to nearest or away from zero.
    public var int: Int { Int(self.rounded(.toNearestOrAwayFromZero)) }
}
