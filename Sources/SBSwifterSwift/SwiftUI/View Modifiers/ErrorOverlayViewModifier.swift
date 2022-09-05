#if canImport(SwiftUI)
import SwiftUI

@available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
fileprivate struct ErrorOverlayViewModifier<E, V>: ViewModifier
where E: Error, V: View {
    
    let error: E?
    
    let animation: Animation?
    
    @ViewBuilder let errorContent: (E) -> V
    
    func body(content: Content) -> some View {
        content
            .overlay(if: error != nil, animation: animation) {
                errorContent(error!)
            }
    }
}

extension View {
    
    @available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
    public func errorOverlay<E, V>(
        _ error: E?,
        animation: Animation? = .easeInOut,
        @ViewBuilder content: @escaping (E) -> V
    ) -> some View
    where E: Error, V: View {
        modifier(ErrorOverlayViewModifier(error: error, animation: animation, errorContent: content))
    }
}
#endif
