import Foundation

public protocol UnitSquare {
    
    associatedtype Factor: Dimension
    
    associatedtype Product: Dimension
    
    static func defaultUnitMapping() -> (Factor, Factor, Product)
    
    static func preferredUnitMappings() -> [(Factor, Factor, Product)]
}

public extension UnitSquare {
    
    static func preferredUnitMappings() -> [(Factor, Factor, Product)] { [] }
    
    static func unitMapping(factor1: Factor, factor2: Factor) -> (Factor, Factor, Product) {
        let match = preferredUnitMappings().first { f1, f2, _ in
            f1 === factor1 && f2 === factor2
        }
        return match ?? defaultUnitMapping()
    }
    
    static func unitMapping(product: Product, factor: Factor) -> (Factor, Factor, Product) {
        let match1 = preferredUnitMappings().first { f1, _, p in
            f1 == factor && p === product
        }
        let match2 = preferredUnitMappings().first { _, f2, p in
            f2 == factor && p === product
        }
        return match1 ?? match2 ?? defaultUnitMapping()
    }
}

/// UnitSquare.Product = Factor * Factor
public func * <UnitType>(
    lhs: Measurement<UnitType.Factor>,
    rhs: Measurement<UnitType.Factor>
) -> Measurement<UnitType> where UnitType: UnitSquare, UnitType.Product == UnitType {
    let (leftUnit, rightUnit, resultUnit) = UnitType.defaultUnitMapping()
    let value = lhs.converted(to: leftUnit).value * rhs.converted(to: rightUnit).value
    let result = Measurement(value: value, unit: resultUnit)
    let (_, _, preferredUnit) = UnitType.unitMapping(factor1: lhs.unit, factor2: rhs.unit)
    return result.converted(to: preferredUnit)
}

/// UnitSquare / Factor = Factor
public func / <UnitType>(
    lhs: Measurement<UnitType>,
    rhs: Measurement<UnitType.Factor>
) -> Measurement<UnitType.Factor> where UnitType: UnitSquare, UnitType.Product == UnitType {
    let (resultUnit, rightUnit, leftUnit) = UnitType.defaultUnitMapping()
    let value = lhs.converted(to: leftUnit).value / rhs.converted(to: rightUnit).value
    let result = Measurement(value: value, unit: resultUnit)
    let (preferredUnit, _, _) = UnitType.unitMapping(product: lhs.unit, factor: rhs.unit)
    return result.converted(to: preferredUnit)
}
