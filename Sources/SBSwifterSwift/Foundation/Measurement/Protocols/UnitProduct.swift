import Foundation

/// Describes a mathematical relationship between three `Dimension` types
/// where `Factor1` * `Factor2` = `Product`.
///
/// Example:
/// `UnitSpeed` * `UnitDuration` = `UnitLength
public protocol UnitProduct {
    
    associatedtype Factor1: Dimension
    
    associatedtype Factor2: Dimension
    
    associatedtype Product: Dimension
    
    typealias UnitMapping = (Factor1, Factor2, Product)
    
    static func defaultUnitMapping() -> UnitMapping
    
    static func preferredUnitMappings() -> [UnitMapping]
}

public extension UnitProduct {
    
    static func preferredUnitMappings() -> [UnitMapping] { [] }
    
    static func unitMapping(factor1: Factor1, factor2: Factor2) -> UnitMapping {
        let match = preferredUnitMappings().first { f1, f2, _ in
            f1 == factor1 && f2 == factor2
        }
        return match ?? defaultUnitMapping()
    }
    
    static func unitMapping(product: Product, factor2: Factor2) -> UnitMapping {
        let match = preferredUnitMappings().first { _, f2, p in
            p == product && f2 == factor2
        }
        return match ?? defaultUnitMapping()
    }
    
    static func unitMapping(product: Product, factor1: Factor1) -> UnitMapping {
        let match = preferredUnitMappings().first { f1, _, p in
            p == product && f1 == factor1
        }
        return match ?? defaultUnitMapping()
    }
}

/// UnitProduct.Product = Factor1 * Factor2
public func * <UnitType>(
    lhs: Measurement<UnitType.Factor1>,
    rhs: Measurement<UnitType.Factor2>
) -> Measurement<UnitType> where
    UnitType: UnitProduct,
    UnitType == UnitType.Product {
    // Perform the calculation in the default unit mapping
    let (leftUnit, rightUnit, resultUnit) = UnitType.defaultUnitMapping()
    let value = lhs.converted(to: leftUnit).value * rhs.converted(to: rightUnit).value
    let result = Measurement(value: value, unit: resultUnit)

    // Convert to preferred unit mapping
    let (_, _, preferredUnit) = UnitType.unitMapping(factor1: lhs.unit, factor2: rhs.unit)
    return result.converted(to: preferredUnit)
}

/// UnitProduct.Product = Factor2 * Factor1
public func * <UnitType>(
    lhs: Measurement<UnitType.Factor2>,
    rhs: Measurement<UnitType.Factor1>
) -> Measurement<UnitType> where
    UnitType: UnitProduct,
    UnitType == UnitType.Product {
    rhs * lhs
}

/// UnitProduct / Factor2 = Factor1
public func / <UnitType>(
    lhs: Measurement<UnitType>,
    rhs: Measurement<UnitType.Factor2>
) -> Measurement<UnitType.Factor1> where
    UnitType: UnitProduct,
    UnitType == UnitType.Product {
    // Perform the calculation in the default unit mapping
    let (resultUnit, rightUnit, leftUnit) = UnitType.defaultUnitMapping()
    let value = lhs.converted(to: leftUnit).value / rhs.converted(to: rightUnit).value
    let result = Measurement(value: value, unit: resultUnit)
    
    // Convert to preferred unit mapping
    let (preferredUnit, _, _) = UnitType.unitMapping(product: lhs.unit, factor2: rhs.unit)
    return result.converted(to: preferredUnit)
}

/// UnitProduct / Factor1 = Factor2
public func / <UnitType>(
    lhs: Measurement<UnitType>,
    rhs: Measurement<UnitType.Factor1>
) -> Measurement<UnitType.Factor2> where
    UnitType: UnitProduct,
    UnitType == UnitType.Product {
    // Perform the calculation in the default unit mapping
    let (rightUnit, resultUnit, leftUnit) = UnitType.defaultUnitMapping()
    let value = lhs.converted(to: leftUnit).value / rhs.converted(to: rightUnit).value
    let result = Measurement(value: value, unit: resultUnit)
    
    // Convert to preferred unit mapping
    let (_, preferredUnit, _) = UnitType.unitMapping(product: lhs.unit, factor1: rhs.unit)
    return result.converted(to: preferredUnit)
}
