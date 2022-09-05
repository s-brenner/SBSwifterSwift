#if canImport(SwiftUI)
import SwiftUI

@available(iOS 14, tvOS 14, macOS 11, watchOS 7, *)
fileprivate struct LoadingViewModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        LoadingView(isPresented: $isPresented) {
            content
        }
    }
}

@available(iOS 14, tvOS 14, macOS 11, watchOS 7, *)
fileprivate struct LoadingView<Content: View>: View {
    
    @Binding var isPresented: Bool
    
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                content()
                    .disabled(isPresented)
                    .blur(radius: isPresented ? 3 : 0)
                VStack {
                    Text("Loading...").font(.headline)
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                .frame(
                    width: geometry.size.width / 2,
                    height: geometry.size.height / 3
                )
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(isPresented ? 1 : 0)
            }
        }
    }
}

extension View {
    
    @available(iOS 14, tvOS 14, macOS 11, watchOS 7, *)
    public func loading(
        isPresented: Binding<Bool>
    ) -> some View {
        modifier(LoadingViewModifier(isPresented: isPresented))
    }
}
#endif
