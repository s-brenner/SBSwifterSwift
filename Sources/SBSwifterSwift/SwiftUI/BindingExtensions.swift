#if canImport(SwiftUI) && os(iOS)
import SwiftUI

extension Binding {
    
    public static func mock(_ value: Value) -> Self {
        var value = value
        return Binding(
            get: { value },
            set: { value = $0 }
        )
    }
}
#endif
