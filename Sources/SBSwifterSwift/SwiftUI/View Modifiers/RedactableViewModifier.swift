#if canImport(SwiftUI)
import SwiftUI

@available(iOS 14, tvOS 14, macOS 11, watchOS 7, *)
fileprivate struct RedactableViewModifier: ViewModifier {
    
    let type: RedactionType?
    
    @State private var condition = false
    
    func body(content: Content) -> some View {
        if let type = type {
            content
                .accessibilityLabel(Text(type.rawValue))
                .redacted(reason: .placeholder)
                .if(type == .customPlaceholder) { $0.opacity(condition ? 0 : 1) }
                .if(type == .blurred) { $0.blur(radius: condition ? 0 : 4) }
                .if(type == .scaled) { $0.scaleEffect(condition ? 0.9 : 1) }
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: condition)
                .onAppear { condition = true }
        }
        else {
            content
        }
    }
}

@available(iOS 14, tvOS 14, macOS 11, watchOS 7, *)
public enum RedactionType: String {
    case customPlaceholder = "Placeholder"
    case scaled = "Scaled"
    case blurred = "Blurred"
}

extension View {
    
    @available(iOS 14, tvOS 14, macOS 11, watchOS 7, *)
    public func redacted(reason: RedactionType?) -> some View {
        modifier(RedactableViewModifier(type: reason))
    }
    
    @available(iOS 14, tvOS 14, macOS 11, watchOS 7, *)
    @ViewBuilder
    public func redacted(when condition: Bool, reason: RedactionType) -> some View {
        if !condition {
            unredacted()
        } else {
            redacted(reason: reason)
        }
    }
}
#endif
