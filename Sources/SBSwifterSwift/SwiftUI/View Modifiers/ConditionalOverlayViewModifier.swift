#if canImport(SwiftUI)
import SwiftUI

@available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
fileprivate struct ConditionalOverlayViewModifier<V: View>: ViewModifier {
    
    let condition: Bool
    
    let animation: Animation?
    
    @ViewBuilder let overlayContent: () -> V
    
    func body(content: Content) -> some View {
        content
            .opacity(condition ? 0 : 1)
            .overlay {
                if condition {
                    overlayContent()
                        .opacity(condition ? 1 : 0)
                }
            }
            .animation(animation, value: condition)
    }
}

extension View {
    
    @available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
    public func overlay<V: View>(
        if condition: Bool,
        animation: Animation? = .easeInOut,
        @ViewBuilder content: @escaping () -> V
    ) -> some View {
        modifier(ConditionalOverlayViewModifier(condition: condition, animation: animation, overlayContent: content))
    }
}
#endif
