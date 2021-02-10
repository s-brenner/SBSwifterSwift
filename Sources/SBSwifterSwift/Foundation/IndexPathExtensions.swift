#if os(iOS)
import Foundation

public extension IndexPath {
    
    typealias Identifier = NSString
    
    var identifier: Identifier { "\(row),\(section)" as Identifier }
    
    init?(identifier: Identifier) {
        let integers = (identifier as String).split(separator: ",").compactMap() { Int($0) }
        guard integers.count == 2 else { return nil }
        self.init(row: integers[0], section: integers[1])
    }
}
#endif
