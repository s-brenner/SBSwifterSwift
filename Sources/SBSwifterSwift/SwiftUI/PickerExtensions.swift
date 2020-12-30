#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public extension Picker where
    Label == Text,
    SelectionValue: CaseIterable & CustomStringConvertible & Hashable,
    SelectionValue.AllCases: RandomAccessCollection {
    
    init(
        _ titleKey: LocalizedStringKey,
        selection: Binding<SelectionValue>
    ) where Content == AnyView {
        self.init(titleKey, selection: selection) {
            ForEach(SelectionValue.allCases, id: \.self) { value in
                Text(value.description)
                    .tag(value)
            }
            .eraseToAnyView()
        }
    }
    
    init<S: StringProtocol>(
        _ title: S,
        selection: Binding<SelectionValue>
    ) where Content == AnyView {
        self.init(title, selection: selection) {
            ForEach(SelectionValue.allCases, id: \.self) { value in
                Text(value.description)
                    .tag(value)
            }
            .eraseToAnyView()
        }
    }
}
#endif
