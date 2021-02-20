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
    
    func rounded(
        places: Int = 0,
        rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
    ) -> Measurement<UnitType> {
        .init(value: value.roundedTo(places: places, rule: rule), unit: unit)
    }
    
    static func / (lhs: Self, rhs: Self) -> Double {
        lhs.converted(to: .baseUnit()).value / rhs.converted(to: .baseUnit()).value
    }
}

public func sin(_ angle: Angle) -> Double { sin(angle.converted(to: .radians).value) }

public func cos(_ angle: Angle) -> Double { cos(angle.converted(to: .radians).value) }

public func tan(_ angle: Angle) -> Double { tan(angle.converted(to: .radians).value) }

public typealias Acceleration = Measurement<UnitAcceleration>

public typealias Angle = Measurement<UnitAngle>

public typealias Area = Measurement<UnitArea>

public typealias ConcentrationMass = Measurement<UnitConcentrationMass>

public typealias Dispersion = Measurement<UnitDispersion>

public typealias Duration = Measurement<UnitDuration>

public typealias ElectricCharge = Measurement<UnitElectricCharge>

public typealias ElectricCurrent = Measurement<UnitElectricCurrent>

public typealias ElectricPotentialDifference = Measurement<UnitElectricPotentialDifference>

public typealias ElectricResistance = Measurement<UnitElectricResistance>

public typealias Energy = Measurement<UnitEnergy>

public typealias Frequency = Measurement<UnitFrequency>

public typealias FuelEfficiency = Measurement<UnitFuelEfficiency>

public typealias Illuminance = Measurement<UnitIlluminance>

public typealias Length = Measurement<UnitLength>

public typealias Mass = Measurement<UnitMass>

public typealias Power = Measurement<UnitPower>

public typealias Pressure = Measurement<UnitPressure>

public typealias Speed = Measurement<UnitSpeed>

public typealias Temperature = Measurement<UnitTemperature>

public typealias Volume = Measurement<UnitVolume>
