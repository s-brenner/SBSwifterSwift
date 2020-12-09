import Foundation

public extension Measurement {
    
    init(_ value: Double, _ unit: UnitType) {
        self.init(value: value, unit: unit)
    }
    
    var abs: Self { Measurement(value: Swift.abs(value), unit: unit) }
}

public extension Measurement where UnitType: Dimension {
    
    func isAlmostEqual(to rhs: Measurement<UnitType>, tolerance: Double = 0.00001) -> Bool {
        Swift.abs(rhs.converted(to: unit).value - value) <= tolerance
    }
    
    func rounded(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Measurement<UnitType> {
        Measurement(value: value.rounded(rule), unit: unit)
    }
    
    static func / (lhs: Self, rhs: Self) -> Double {
        lhs.converted(to: .baseUnit()).value / rhs.converted(to: .baseUnit()).value
    }
}
