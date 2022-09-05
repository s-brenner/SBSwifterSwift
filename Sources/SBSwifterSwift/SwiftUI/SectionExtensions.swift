#if canImport(SwiftUI) && os(iOS)
import SwiftUI

extension Section where Parent == Text, Content: View, Footer == EmptyView {
    
    public init(
        header: some StringProtocol,
        uppercased: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            header: uppercased ? Text(header.uppercased()) : Text(header),
            content: content
        )
    }
}

extension Section where Parent == EmptyView, Content: View, Footer == Text {
    
    public init(footer: some StringProtocol, @ViewBuilder content: () -> Content) {
        self.init(footer: Text(footer), content: content)
    }
}

extension Section where Parent == Text, Content: View, Footer == Text {

    public init(
        header: some StringProtocol,
        uppercased: Bool = true,
        footer: some StringProtocol,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            header: uppercased ? Text(header.uppercased()) : Text(header),
            footer: Text(footer),
            content: content
        )
    }
}
#endif
