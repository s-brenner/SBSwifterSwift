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
}
