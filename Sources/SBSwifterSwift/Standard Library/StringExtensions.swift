import Foundation

extension String {
    
    /// CamelCase of string.
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
    
    public func base64Encoded(using encoding: Encoding = .utf8) -> String? {
        
        data(using: encoding)?.base64EncodedString()
    }
    
    public func base64Decoded(using encoding: Encoding = .utf8) -> String? {
        
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: encoding)
    }
}
