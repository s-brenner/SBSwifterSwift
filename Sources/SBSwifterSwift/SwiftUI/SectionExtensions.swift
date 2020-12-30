#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public extension Section where Parent == Text, Content: View, Footer == EmptyView {
    
    init<S: StringProtocol>(
        header: S,
        uppercased: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            header: uppercased ? Text(header.uppercased()) : Text(header),
            content: content
        )
    }
}

public extension Section where Parent == EmptyView, Content: View, Footer == Text {
    
    init<S: StringProtocol>(footer: S, @ViewBuilder content: () -> Content) {
        self.init(footer: Text(footer), content: content)
    }
}

public extension Section where Parent == Text, Content: View, Footer == Text {

    init<S1, S2>(
        header: S1,
        uppercased: Bool = true,
        footer: S2,
        @ViewBuilder content: () -> Content
    ) where S1: StringProtocol, S2: StringProtocol {
        self.init(
            header: uppercased ? Text(header.uppercased()) : Text(header),
            footer: Text(footer),
            content: content
        )
    }
}
#endif
