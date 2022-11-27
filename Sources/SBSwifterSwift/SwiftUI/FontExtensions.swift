#if canImport(SwiftUI) && os(iOS)
import SwiftUI

extension Font {
    
    /// Returns a static font that does not adapt with Dynamic Type
    @available(iOS 16.0, *)
    public static func fixed(_ style: Font.TextStyle, design: Font.Design? = nil) -> Font {
        switch style {
        case .largeTitle: return .system(size: 34, weight: .regular, design: design)
        case .title: return .system(size: 28, weight: .regular, design: design)
        case .title2: return .system(size: 22, weight: .regular, design: design)
        case .title3: return .system(size: 20, weight: .regular, design: design)
        case .headline: return .system(size: 17, weight: .semibold, design: design)
        case .callout: return .system(size: 16, weight: .regular, design: design)
        case .subheadline: return .system(size: 15, weight: .regular, design: design)
        case .body: return .system(size: 17, weight: .regular, design: design)
        case .footnote: return .system(size: 13, weight: .regular, design: design)
        case .caption: return .system(size: 12, weight: .regular, design: design)
        case .caption2: return .system(size: 11, weight: .regular, design: design)
        @unknown default: return .system(style, design: design)
        }
    }
}
#endif
