import Foundation

extension Data {
    
    /// - Author: Scott Brenner | SBSwifterSwift
    public init?(base64URLEncoded input: String) {
        
        var base64 = input
        base64 = base64.replacingOccurrences(of: "-", with: "+")
        base64 = base64.replacingOccurrences(of: "_", with: "/")
        while base64.count % 4 != 0 {
            base64 = base64.appending("=")
        }
        self.init(base64Encoded: base64)
    }

    /// Returns a Base-64 URL encoded string.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Returns: The Base-64 URL encoded string.
    public func base64URLEncodedString() -> String {
        
        var result = self.base64EncodedString()
        result = result.replacingOccurrences(of: "+", with: "-")
        result = result.replacingOccurrences(of: "/", with: "_")
        result = result.replacingOccurrences(of: "=", with: "")
        return result
    }
}
