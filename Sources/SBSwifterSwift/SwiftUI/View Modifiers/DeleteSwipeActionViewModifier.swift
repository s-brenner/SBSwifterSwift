#if canImport(SwiftUI)
import SwiftUI

@available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
fileprivate struct DeleteSwipeActionViewModifier: ViewModifier {
    
    let onDelete: () -> Void
    
    func body(content: Content) -> some View {
        content
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                    onDelete()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
    }
}

extension View {
    
    @available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
    public func deleteSwipeAction(onDelete: @escaping () -> Void) -> some View {
        modifier(DeleteSwipeActionViewModifier(onDelete: onDelete))
    }
}
#endif
