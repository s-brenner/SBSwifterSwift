import Darwin
import CoreGraphics

extension Float {
    
    /// Double.
    public var double: Double { Double(self) }

    /// CGFloat.
    public var cgFloat: CGFloat { CGFloat(self) }
    
    /// Int. Rounded to nearest or away from zero.
    public var int: Int { Int(self.rounded(.toNearestOrAwayFromZero)) }
}
