#if canImport(SwiftUI)
import SwiftUI

fileprivate struct EmptyStateViewModifier<EmptyContent: View>: ViewModifier {
    
    var isEmpty: Bool
    
    @ViewBuilder let emptyContent: () -> EmptyContent
    
    func body(content: Content) -> some View {
        if isEmpty {
            emptyContent()
        }
        else {
            content
        }
    }
}

extension View {
    
    public func emptyState<EmptyContent: View>(
        _ isEmpty: Bool,
        @ViewBuilder content: @escaping () -> EmptyContent
    ) -> some View {
        modifier(EmptyStateViewModifier(isEmpty: isEmpty, emptyContent: content))
    }
}
#endif
