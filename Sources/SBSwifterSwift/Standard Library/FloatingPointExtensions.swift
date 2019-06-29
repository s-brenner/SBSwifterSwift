import Foundation

extension FloatingPoint {
    
    /// Radian value of degree input.
    public var degreesToRadians: Self { self * .pi / 180 }
    
    /// Degree value of radian input.
    public var radiansToDegrees: Self { self * 180 / .pi }
    
    /// The ceiling of a number.
    public var ceil: Self { Foundation.ceil(self) }
    
    /// The floor of number.
    public var floor: Self { Foundation.floor(self) }
}
