import Foundation

public extension Comparable {
    
    /// Moves the value to a range of allowed values.
    /// - Parameter range: The range of allowed values.
    func clamped(to range: ClosedRange<Self>) -> Self {
        return max(min(self, range.upperBound), range.lowerBound)
    }
}


public extension Comparable where Self: SignedNumeric {
    
    /// Check if a number is negative.
    var isNegative: Bool { self < 0 }
    
    /// Check if a number is positive.
    var isPositive: Bool { self > 0 }
    
    /// The absolute value of a number.
    var abs: Self { return Swift.abs(self) }
}
