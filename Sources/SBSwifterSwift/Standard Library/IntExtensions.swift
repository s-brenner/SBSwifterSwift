import Darwin
import CoreGraphics

extension Int {
    
    /// CountableRange 0..<Int.
    public var countableRange: CountableRange<Int> { 0..<self }
    
    /// Radian value of degree input.
    public var degreesToRadians: Double { self.double.degreesToRadians }
    
    /// Degree value of radian input
    public var radiansToDegrees: Double { self.double.radiansToDegrees }
    
    /// UInt.
    public var uInt: UInt { UInt(self) }
    
    /// Double.
    public var double: Double { Double(self) }
    
    /// Float.
    public var float: Float { Float(self) }
    
    /// CGFloat.
    public var cgFloat: CGFloat { CGFloat(self) }
    
    /// Rounds to the closest multiple of n.
    public func roundToNearest(_ number: Int) -> Int {
        return number == 0 ? self : Int(round(self.double / number.double)) * number
    }
}
