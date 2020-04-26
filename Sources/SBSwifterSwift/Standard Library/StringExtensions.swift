import Foundation

extension String {
    
    /// Camel cased string.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// ````
    /// "sOme vAriable naMe".camelCased
    /// // "someVariableName"
    /// ````
    public var camelCased: String {
        let source = capitalized.removingAll([" ", "\n"])
        let first = source[..<source.index(after: source.startIndex)].lowercased()
        let rest = String(source.dropFirst())
        return first + rest
    }
    
    /// Returns the Base-64 encoding of the receiver.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter encoding: The text encoding to use.
    /// - Returns: The Base-64 encoding of the receiver.
    public func base64Encoded(using encoding: Encoding = .utf8) -> String? {
        
        data(using: encoding)?.base64EncodedString()
    }
    
    /// Returns the Base-64 decoding of the receiver.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter encoding: The text encoding to use.
    /// - Returns: The Base-64 decoding of the receiver.
    public func base64Decoded(using encoding: Encoding = .utf8) -> String? {
        
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: encoding)
    }
    
    /// Returns the Base-64 URL encoding of the receiver.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter encoding: The text encoding to use.
    /// - Returns: The Base-64 URL encoding of the receiver.
    public func base64URLEncoded(using encoding: Encoding = .utf8) -> String? {
        
        guard var result = base64Encoded(using: encoding) else { return nil }
        result = result.replacingOccurrences(of: "+", with: "-")
        result = result.replacingOccurrences(of: "/", with: "_")
        result = result.replacingOccurrences(of: "=", with: "")
        return result
    }
    
    /// A random string of a prescribed length including only the allowed characters.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter length: The number of characters in the output.
    /// - Parameter allowed: The characters allowed in the output.
    public init(
        randomWithLength length: Int,
        allowedCharacters allowed: AllowedCharacters = .alphaNumeric) {
        
        self = String((0..<length).map { _ in allowed.characters.randomElement()! })
    }
    
    /// Returns a Boolean value that indicates whether the receiver contains only the allowed characters.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n), where n is the length of the receiver.
    /// - Parameter allowed: The characters allowed in the receiver.
    /// - Returns: `true` if receiver contains only the allowed characters; otherwise, `false`.
    public func contains(only allowed: AllowedCharacters) -> Bool {
        
        let characters = Set(allowed.characters)
        for element in self {
            guard characters.contains(element) else { return false }
        }
        return true
    }
    
    public enum AllowedCharacters: CustomStringConvertible {
        
        /// Allow all numbers from 0 to 9.
        case numeric
        
        /// Allow all alphabetic characters ignoring case.
        case alphabetic
        
        /// Allow both numbers and alphabetic characters ignoring case.
        case alphaNumeric
        
        /// Allow all characters appearing within the specified String.
        case allCharactersIn(String)
        
        public var characters: [Character] { Array(description) }
        
        public var description: String {
            switch self {
            case .numeric:
                return "0123456789"
                
            case .alphabetic:
                return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                
            case .alphaNumeric:
                return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
                
            case .allCharactersIn(let allowed):
                return allowed
            }
        }
    }
}
