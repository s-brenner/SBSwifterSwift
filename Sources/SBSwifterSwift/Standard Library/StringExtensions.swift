import Foundation

public extension String {
    
    /// - Author: Scott Brenner | SBSwifterSwift
    var bytes: [UInt8] { .init(self.utf8) }
    
    /// Returns the camelcased conversion of the receiver.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// ````
    /// "sOme vAriable naMe".camelCased
    /// // "someVariableName"
    /// ````
    /// - Returns: The camelcased conversion of the receiver.
    func camelcased() -> Self {
        let source = capitalized.removingAll([" ", "\n", "_"])
        let first = source[..<source.index(after: source.startIndex)].lowercased()
        let rest = String(source.dropFirst())
        return first + rest
    }
    
    /// Returns the Base-64 encoding of the receiver.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter encoding: The text encoding to use.
    /// - Returns: The Base-64 encoding of the receiver.
    func base64Encoded(using encoding: Encoding = .utf8) -> Self? {
        data(using: encoding)?.base64EncodedString()
    }
    
    /// Returns the Base-64 decoding of the receiver.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter encoding: The text encoding to use.
    /// - Returns: The Base-64 decoding of the receiver.
    func base64Decoded(using encoding: Encoding = .utf8) -> Self? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: encoding)
    }
    
    /// Returns the Base-64 URL encoding of the receiver.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter encoding: The text encoding to use.
    /// - Returns: The Base-64 URL encoding of the receiver.
    func base64URLEncoded(using encoding: Encoding = .utf8) -> Self? {
        data(using: encoding)?.base64URLEncodedString()
    }
    
    /// Returns the Base-64 URL decoding of the receiver.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter encoding: The text encoding to use.
    /// - Returns: The Base-64 URL decoding of the receiver.
    func base64URLDecoded(using encoding: Encoding = .utf8) -> Self? {
        guard let data = Data(base64URLEncoded: self) else { return nil }
        return String(data: data, encoding: encoding)
    }
    
    /// A random string of a prescribed length including only the allowed characters.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter length: The number of characters in the output.
    /// - Parameter allowed: The characters allowed in the output.
    init(
        randomWithLength length: Int,
        allowedCharacters allowed: AllowedCharacters = .alphaNumeric
    ) {
        self = String((0..<length).map { _ in allowed.characters.randomElement()! })
    }
    
    /// Returns a Boolean value that indicates whether the receiver contains only the allowed characters.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n), where n is the length of the receiver.
    /// - Parameter allowed: The characters allowed in the receiver.
    /// - Returns: `true` if receiver contains only the allowed characters; otherwise, `false`.
    func contains(only allowed: AllowedCharacters) -> Bool {
        allowed.characters.contains(self, matchedBy: { $0 == $1 })
    }
    
    enum AllowedCharacters: CustomStringConvertible {
        
        /// Allow all numbers from 0 to 9.
        case numeric
        
        /// Allow all alphabetic characters ignoring case.
        case alphabetic
        
        /// Allow both numbers and alphabetic characters ignoring case.
        case alphaNumeric
        
        /// Allow all characters appearing within the specified String.
        case allCharactersIn(String)
        
        public var characters: Set<Character> { Set(description) }
        
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
        
        public static func +(lhs: Self, rhs: Self) -> Self {
            .allCharactersIn(String(lhs.characters.union(rhs.characters)))
        }
        
        public static func -(lhs: Self, rhs: Self) -> Self {
            .allCharactersIn(String(lhs.characters.subtracting(rhs.characters)))
        }
    }
    
    /// Returns a localized string.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter key: The key in the .strings file that corresponds to a localized value.
    /// - Returns: A localized string.
    static func localized(_ key: Localizable) -> String {
        key.contents
    }
    
    /// - Author: Scott Brenner | SBSwifterSwift
    struct Localizable: ExpressibleByStringLiteral {
        
        fileprivate let contents: String
        
        public init(_ key: String, comment: String = "") {
            contents = NSLocalizedString(key, comment: comment)
        }
        
        public init(stringLiteral value: StringLiteralType) {
            self.init(value)
        }
    }
}
