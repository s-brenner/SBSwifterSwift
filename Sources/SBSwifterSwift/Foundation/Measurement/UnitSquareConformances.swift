import Foundation

extension UnitArea: UnitSquare {
    
    public typealias Factor = UnitLength
    
    public typealias Product = UnitArea
    
    public static func defaultUnitMapping() -> (UnitLength, UnitLength, UnitArea) {
        (.meters, .meters, .squareMeters)
    }
    
    public static func preferredUnitMappings() -> [(UnitLength, UnitLength, UnitArea)] {
        [
            (.megameters, .megameters, .squareMegameters),
            (.kilometers, .kilometers, .squareKilometers),
            (.centimeters, .centimeters, .squareCentimeters),
            (.millimeters, .millimeters, .squareMillimeters),
            (.micrometers, .micrometers, .squareMicrometers),
            (.nanometers, .nanometers, .squareNanometers),
            (.inches, .inches, .squareInches),
            (.feet, .feet, .squareFeet),
            (.yards, .yards, .squareYards),
            (.miles, .miles, squareMiles)
        ]
    }
}
