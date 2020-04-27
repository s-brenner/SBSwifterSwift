import XCTest
@testable import SBSwifterSwift

final class StringExtensionsTests: XCTestCase {
    
    func testCamelCased() {
        
        XCTAssertEqual("SoMe vAriable naMe".camelCased, "someVariableName")
    }
    
    func testBase64() {
        
        let string = "test:secret"
        let base64 = string.base64Encoded()
        let random = String(randomWithLength: 100)
        
        XCTAssertEqual(base64, "dGVzdDpzZWNyZXQ=")
        XCTAssertEqual(base64?.base64Decoded(), string)
        XCTAssertEqual(random.base64Encoded()?.base64Decoded(), random)
    }
    
    func testRandom() {
        
        let allowed: [String.AllowedCharacters] = [.numeric, .alphabetic, .alphaNumeric]
        allowed.forEach {
            
            let length = 100
            let random = String(randomWithLength: 100, allowedCharacters: $0)
            
            XCTAssertEqual(random.count, length)
            XCTAssertTrue(random.contains(only: $0))
        }
        
    }
    
    func testContainsOnly() {
        
        let numeric = "80841"
        let alphabetic = "hello"
        let alphaNumeric = numeric + alphabetic
        let complex = alphaNumeric + "!@$"
        let symbols = "~!@#$%^&*()"
        
        XCTAssertTrue(numeric.contains(only: .numeric))
        XCTAssertFalse(numeric.contains(only: .alphabetic))
        XCTAssertTrue(numeric.contains(only: .alphaNumeric))
        XCTAssertFalse(numeric.contains(only: .allCharactersIn(symbols)))
        
        XCTAssertFalse(alphabetic.contains(only: .numeric))
        XCTAssertTrue(alphabetic.contains(only: .alphabetic))
        XCTAssertTrue(alphabetic.contains(only: .alphaNumeric))
        XCTAssertFalse(alphabetic.contains(only: .allCharactersIn(symbols)))
        
        XCTAssertFalse(alphaNumeric.contains(only: .numeric))
        XCTAssertFalse(alphaNumeric.contains(only: .alphabetic))
        XCTAssertTrue(alphaNumeric.contains(only: .alphaNumeric))
        XCTAssertFalse(alphaNumeric.contains(only: .allCharactersIn(symbols)))
        
        XCTAssertFalse(complex.contains(only: .numeric))
        XCTAssertFalse(complex.contains(only: .alphabetic))
        XCTAssertFalse(complex.contains(only: .alphaNumeric))
        XCTAssertFalse(complex.contains(only: .allCharactersIn(symbols)))
        XCTAssertTrue(complex.contains(only: .alphaNumeric + .allCharactersIn(symbols)))
        
        XCTAssertTrue("012345678".contains(only: .numeric - .allCharactersIn("9")))
    }
}
