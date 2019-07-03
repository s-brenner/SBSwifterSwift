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
}
