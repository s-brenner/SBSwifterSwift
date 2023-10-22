import Foundation

extension BinaryFloatingPoint {
    
    ///Int.
    public var int: Int { Int(self) }
    
    public func roundedTo(
        places: Int = 0,
        rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
    ) -> Self {
        let divisor = Self(pow(10, Double(places)))
        return (self * divisor).rounded(rule) / divisor
    }
}
