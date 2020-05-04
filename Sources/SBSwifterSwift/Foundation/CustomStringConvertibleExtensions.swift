import Foundation

public extension CustomStringConvertible where Self: Encodable {
    
    var description: String {
        guard let string = try? JSONEncoder().encode(self) else { return "{}" }
        return string.prettyPrintedJSONString
    }
}
