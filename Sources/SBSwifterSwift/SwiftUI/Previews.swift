#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public enum Previews {
    
    public struct ComponentPreview<Component: View>: View {
        
        var component: Component
        
        public var body: some View {
            ForEach(values: ColorScheme.allCases) { scheme in
                ForEach(values: ContentSizeCategory.smallestAndLargest) { category in
                    self.component
                        .previewLayout(.sizeThatFits)
                        .background(Color(UIColor.systemBackground))
                        .colorScheme(scheme)
                        .environment(\.sizeCategory, category)
                        .previewDisplayName(
                            "\(scheme.previewName) + \(category.previewName)"
                        )
                }
            }
        }
    }
    
    public struct ScreenPreview<Screen: View>: View {
        
        let screen: Screen
        
        let devices: [PreviewDevice]
        
        let navigationBarTitle: String?
        
        public var body: some View {
            ForEach(values: devices.map(\.rawValue)) { device in
                ForEach(values: ColorScheme.allCases) { scheme in
                    NavigationView {
                        self.screen
                            .navigationBarTitle(self.navigationBarTitle ?? "")
                            .navigationBarHidden(self.navigationBarTitle == nil)
                    }
                    .previewDevice(PreviewDevice(rawValue: device))
                    .colorScheme(scheme)
                    .previewDisplayName("\(scheme.previewName): \(device)")
                }
            }
        }
    }
}


public extension View {
    
    func previewAsScreen(
        on devices: [PreviewDevice] = [.iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax, .iPhoneSE3rdGen],
        withTitle title: String? = nil
    ) -> some View {
        Previews.ScreenPreview(screen: self, devices: devices, navigationBarTitle: title)
    }
    
    func previewAsComponent() -> some View {
        Previews.ComponentPreview(component: self)
    }
}


fileprivate extension ColorScheme {
    
    var previewName: String {
        String(describing: self).capitalized
    }
}


fileprivate extension ContentSizeCategory {
    
    static let smallestAndLargest = [allCases.first!, allCases.last!]

    var previewName: String {
        self == Self.smallestAndLargest.first ? "Small" : "Large"
    }
}


fileprivate extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
    
    init(values: Data, content: @escaping (Data.Element) -> Content) {
        self.init(values, id: \.self, content: content)
    }
}
#endif
