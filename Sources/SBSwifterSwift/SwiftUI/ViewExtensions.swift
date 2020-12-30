#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public extension View {
    
    func openURL(_ url: URL) {
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @available(iOS, introduced: 13, deprecated: 14, message: "Use .navigationTitle directly")
    @ViewBuilder func title<S: StringProtocol>(_ title: S) -> some View {
        if #available(iOS 14, *) {
            navigationTitle(title)
        } else {
            navigationBarTitle(title)
        }
    }
    
    @available(iOS, introduced: 13, deprecated: 14, message: "Use .toolbar directly")
    @ViewBuilder func confirmationActionToolbarItem<Content: View>(
        @ViewBuilder _ content: () -> Content
    ) -> some View {
        if #available(iOS 14, *) {
            toolbar {
                ToolbarItem(placement: .confirmationAction) { content() }
            }
        } else {
            navigationBarItems(trailing: content().font(.headline))
        }
    }
    
    func eraseToAnyView() -> AnyView {
        .init(self)
    }
    
    @ViewBuilder func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
#endif
