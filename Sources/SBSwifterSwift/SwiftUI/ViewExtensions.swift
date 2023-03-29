#if canImport(SwiftUI)
import SwiftUI

public extension View {
    
    func eraseToAnyView() -> AnyView {
        .init(self)
    }
    
    @ViewBuilder func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
#endif
