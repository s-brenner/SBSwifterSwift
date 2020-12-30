#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public extension Binding {
    
    static func mock(_ value: Value) -> Self {
        var value = value
        return Binding(
            get: { value },
            set: { value = $0 }
        )
    }
}
#endif
