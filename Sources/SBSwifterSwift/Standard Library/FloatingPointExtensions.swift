import Foundation

extension FloatingPoint {
    
    /// The absolute value of a number.
    public var abs: Self { Swift.abs(self) }
    
    /// Check if a number is positive.
    public var isPositive: Bool { self > 0 }
    
    /// Check if a number is negative.
    public var isNegative: Bool { self < 0 }
    
    /// Radian value of degree input.
    public var degreesToRadians: Self { self * .pi / 180 }
    
    /// Degree value of radian input.
    public var radiansToDegrees: Self { self * 180 / .pi }
    
    /// The ceiling of a number.
    public var ceil: Self { Foundation.ceil(self) }
    
    /// The floor of number.
    public var floor: Self { Foundation.floor(self) }
}
