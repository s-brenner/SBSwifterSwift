#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public extension Button where Label == Image {
    
    init(systemImage: String, action: @escaping () -> Void) {
        self.init(action: action) {
            Image(systemName: systemImage)
        }
    }
}

@available(iOS 14.0, *)
public extension Button where Label == SwiftUI.Label<Text, Image> {
    
    init(_ label: Label, action: @escaping () -> Void) {
        self.init(action: action) {
            label
        }
    }
    
    init(_ title: String, systemImage: String, action: @escaping () -> Void) {
        self.init(action: action) {
            Label(title, systemImage: systemImage)
        }
    }
}
#endif
