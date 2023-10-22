import Foundation

public extension Data {
    
    /// - Author: Scott Brenner | SBSwifterSwift
    init?(base64URLEncoded input: String) {
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
    func base64URLEncodedString() -> String {
        var result = self.base64EncodedString()
        result = result.replacingOccurrences(of: "+", with: "-")
        result = result.replacingOccurrences(of: "/", with: "_")
        result = result.replacingOccurrences(of: "=", with: "")
        return result
    }
     
    /// - Author: Scott Brenner | SBSwifterSwift
    var prettyPrintedJSONString: String {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let string = String(data: data, encoding: .utf8) else {
                return ""
        }
        return string
    }
    
    func string(encoding: String.Encoding = .utf8) -> String? {
        String(data: self, encoding: encoding)
    }
}
