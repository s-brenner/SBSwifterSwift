import Foundation

extension String {
    
    /// CamelCase of string.
    /// ````
    /// "sOme vAriable naMe".camelCased
    /// // "someVariableName"
    /// ````
    public var camelCased: String {
        let source = lowercased()
        let first = source[..<source.index(after: source.startIndex)]
        if source.contains(" ") {
            let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
            let camel = connected.replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.dropFirst())
            return first + rest
        }
        let rest = String(source.dropFirst())
        return first + rest
    }
}
