public extension Int {
    
    /// CountableRange 0..<Int.
    var countableRange: CountableRange<Int> { 0..<self }
    
    /// Radian value of degree input.
    var degreesToRadians: Double { self.double.degreesToRadians }
    
    /// Degree value of radian input
    var radiansToDegrees: Double { self.double.radiansToDegrees }
    
    /// UInt.
    var uInt: UInt { UInt(self) }
    
    /// Double.
    var double: Double { Double(self) }
    
    /// Float.
    var float: Float { Float(self) }
    
    /// CGFloat.
    var cgFloat: CGFloat { CGFloat(self) }
    
    /// Rounds to the closest multiple of n.
    func roundToNearest(_ number: Int) -> Int {
        number == 0 ? self : Int(round(self.double / number.double)) * number
    }
    
    /// Returns the modulus of dividing the by the divisor.
    ///
    /// The result has the same sign as the divisor and has a magnitude less than the divisor.
    /// - Parameter divisor: The divisor. Must not be zero.
    func mod(_ divisor: Int) -> Int {
        guard divisor != 0 else { fatalError("Division by zero in modulo operation.") }
        return (self % divisor + divisor) % divisor
    }
}
