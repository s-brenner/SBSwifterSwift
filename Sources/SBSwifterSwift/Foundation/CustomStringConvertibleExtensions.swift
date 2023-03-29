import Foundation

extension CustomStringConvertible where Self: Encodable {
    
    public var description: String {
        guard let data = try? JSONEncoder().encode(self) else { return "{}" }
        return data.prettyPrintedJSONString
    }
}
