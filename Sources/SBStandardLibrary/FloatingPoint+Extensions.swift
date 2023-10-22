public extension FloatingPoint {
    
    /// Radian value of degree input.
    var degreesToRadians: Self { self * .pi / 180 }
    
    /// Degree value of radian input.
    var radiansToDegrees: Self { self * 180 / .pi }
    
    /// The ceiling of a number.
    var ceil: Self { Foundation.ceil(self) }
    
    /// The floor of number.
    var floor: Self { Foundation.floor(self) }
}
