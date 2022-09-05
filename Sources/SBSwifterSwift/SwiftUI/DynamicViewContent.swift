#if canImport(SwiftUI) && os(iOS)
import SwiftUI

extension DynamicViewContent {
    
    @available(iOS, introduced: 13, deprecated: 15, message: "Use swipeActions instead")
    public func onConfirmedDelete(
        title: @escaping (IndexSet) -> String,
        message: String? = nil,
        deleteTitle: @escaping (IndexSet) -> String = { _ in "Delete"},
        action: @escaping (IndexSet) -> Void
    ) -> some View {
        DeleteConfirmation(
            source: self,
            title: title,
            message: message,
            deleteTitle: deleteTitle,
            action: action
        )
    }
    
    @available(iOS, introduced: 13, deprecated: 15, message: "Use swipeActions instead")
    public func onConfirmedDelete(
        item: @escaping (IndexSet) -> String,
        action: @escaping (IndexSet) -> Void
    ) -> some View {
        DeleteConfirmation(
            source: self,
            title: { "Are you sure you want to delete this \(item($0))?" },
            message: nil,
            deleteTitle: { "Delete \(item($0))" },
            action: action
        )
    }
}


struct DeleteConfirmation<Source>: View where Source: DynamicViewContent {
    
    let source: Source
    
    let title: (IndexSet) -> String
    
    let message: String?
    
    let deleteTitle: (IndexSet) -> String
    
    let action: (IndexSet) -> Void
    
    @State private var indexSet: IndexSet = []
    
    @State private var isPresented: Bool = false

    var body: some View {
        source
            .onDelete { indexSet in
                self.indexSet = indexSet
                isPresented = true
            }
            .actionSheet(isPresented: $isPresented) {
                ActionSheet(
                    title: Text(title(indexSet)),
                    message: message == nil ? nil : Text(message!),
                    buttons: [
                        .destructive(Text(deleteTitle(indexSet))) {
                            withAnimation {
                                action(indexSet)
                            }
                        },
                        .cancel()
                    ]
                )
            }
    }
}
#endif
