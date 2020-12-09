import Foundation

extension UnitLength: UnitProduct {
    
    public typealias Factor1 = UnitSpeed
    
    public typealias Factor2 = UnitDuration
    
    public typealias Product = UnitLength
    
    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        (.metersPerSecond, .seconds, .meters)
    }
    
    public static func preferredUnitMappings() -> [(Factor1, Factor2, Product)] {
        [
            (.kilometersPerHour, .hours, .kilometers),
            (.milesPerHour, .hours, .miles),
            (.knots, .hours, .nauticalMiles),
        ]
    }
}

extension UnitVolume: UnitProduct {
    
    public typealias Factor1 = UnitArea
    
    public typealias Factor2 = UnitLength
    
    public typealias Product = UnitVolume
    
    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        (.squareMeters, .meters, .cubicMeters)
    }
    
    public static func preferredUnitMappings() -> [(Factor1, Factor2, Product)] {
        [
            (.squareMillimeters, .millimeters, .cubicMillimeters),
            (.squareCentimeters, .centimeters, .cubicCentimeters),
            (.squareInches, .inches, .cubicInches),
            (.squareFeet, .feet, .cubicFeet),
            (.squareYards, .yards, .cubicYards),
        ]
    }
}

extension UnitSpeed: UnitProduct {
    
    public typealias Factor1 = UnitAcceleration
    
    public typealias Factor2 = UnitDuration
    
    public typealias Product = UnitSpeed
    
    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        (.metersPerSecondSquared, .seconds, .metersPerSecond)
    }
}

extension UnitMass: UnitProduct {
    
    public typealias Factor1 = UnitConcentrationMass
    
    public typealias Factor2 = UnitVolume
    
    public typealias Product = UnitMass
    
    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        (.gramsPerLiter, .liters, .grams)
    }
}

extension UnitElectricPotentialDifference: UnitProduct {
    
    public typealias Factor1 = UnitElectricResistance
    
    public typealias Factor2 = UnitElectricCurrent
    
    public typealias Product = UnitElectricPotentialDifference
    
    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        (.ohms, .amperes, .volts)
    }
}

extension UnitEnergy: UnitProduct {
    
    public typealias Factor1 = UnitPower
    
    public typealias Factor2 = UnitDuration
    
    public typealias Product = UnitEnergy
    
    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        (.watts, .seconds, .joules)
    }
}

extension UnitElectricCharge: UnitProduct {
    
    public typealias Factor1 = UnitElectricCurrent
    
    public typealias Factor2 = UnitDuration
    
    public typealias Product = UnitElectricCharge
    
    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        (.amperes, .seconds, .coulombs)
    }
}
