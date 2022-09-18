#if canImport(SwiftUI)
import SwiftUI

@available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
fileprivate struct LoadingViewModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    
    var onCancel: (() -> Void)?
    
    func body(content: Content) -> some View {
        LoadingView(isPresented: $isPresented, onCancel: onCancel) {
            content
        }
    }
}

@available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
fileprivate struct LoadingView<Content: View>: View {
    
    @Binding var isPresented: Bool
    
    var onCancel: (() -> Void)?
    
    @ViewBuilder let content: () -> Content
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                ZStack(alignment: .topTrailing) {
                    content()
                        .disabled(isPresented)
                        .blur(radius: isPresented ? 3 : 0, opaque: colorScheme == .dark)
                    if let onCancel {
                        Button(action: onCancel) {
                            Image(systemName: "xmark.circle.fill")
                        }
                        .tint(.gray)
                        .padding()
                    }
                }
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
    
    @available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
    public func loading(
        isPresented: Binding<Bool>,
        onCancel: (() -> Void)?
    ) -> some View {
        modifier(LoadingViewModifier(isPresented: isPresented, onCancel: onCancel))
    }
}
#endif
