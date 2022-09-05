#if canImport(SwiftUI)
import SwiftUI

@available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
fileprivate struct ConfirmedDeleteSwipeActionViewModifier<S: StringProtocol>: ViewModifier {
    
    let requiresConfirmation: Bool
    
    let titleVisibility: Visibility
    
    let title: () -> S
    
    let message: () -> S
                  
    let onDelete: () -> Void
    
    @State private var isPresented = false
    
    func body(content: Content) -> some View {
        content
            .deleteSwipeAction {
                if requiresConfirmation {
                    isPresented = true
                }
                else {
                    onDelete()
                }
            }
            .confirmationDialog(title(), isPresented: $isPresented, titleVisibility: titleVisibility) {
                Button("Delete", role: .destructive, action: onDelete)
            } message: {
                Text(message())
            }
    }
}

extension View {
    
    @available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
    public func confirmedDeleteSwipeAction<S: StringProtocol>(
        _ requiresConfirmation: Bool = true,
        titleVisibility: Visibility = .visible,
        title: @escaping () -> S,
        message: @escaping () -> S,
        onDelete: @escaping () -> Void
    ) -> some View {
        modifier(
            ConfirmedDeleteSwipeActionViewModifier(
                requiresConfirmation: requiresConfirmation,
                titleVisibility: titleVisibility,
                title: title,
                message: message,
                onDelete: onDelete
            )
        )
    }
}
#endif
