import Foundation

extension Comparable {
    
    /// Moves the value to a range of allowed values.
    /// - Parameter range: The range of allowed values.
    public func clamped(to range: ClosedRange<Self>) -> Self {
        return max(min(self, range.upperBound), range.lowerBound)
    }
}
