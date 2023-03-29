#if canImport(SwiftUI) && os(iOS)
import SwiftUI

extension Button where Label == Image {
    
    public init(systemImage: String, action: @escaping () -> Void) {
        self.init(action: action) {
            Image(systemName: systemImage)
        }
    }
}

@available(iOS 14.0, *)
extension Button where Label == SwiftUI.Label<Text, Image> {
    
    public init(_ label: Label, action: @escaping () -> Void) {
        self.init(action: action) {
            label
        }
    }
    
    public init(_ title: String, systemImage: String, action: @escaping () -> Void) {
        self.init(action: action) {
            Label(title, systemImage: systemImage)
        }
    }
}
#endif
