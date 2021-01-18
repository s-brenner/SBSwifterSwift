import Foundation

public extension BinaryFloatingPoint {
    
    ///Int.
    var int: Int { Int(self) }
    
    func roundedTo(
        places: Int = 0,
        rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
    ) -> Self {
        let divisor = Self(pow(10, Double(places)))
        return (self * divisor).rounded(rule) / divisor
    }
}
