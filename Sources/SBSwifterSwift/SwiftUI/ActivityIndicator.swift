#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, *)
public struct ActivityIndicator: UIViewRepresentable {

    @Binding public var isAnimating: Bool
    
    public let style: UIActivityIndicatorView.Style
    
    var configuration: (UIActivityIndicatorView) -> Void
    
    public init(
        isAnimating: Binding<Bool>,
        style: UIActivityIndicatorView.Style,
        configuration: @escaping ((UIActivityIndicatorView) -> Void) = { _ in }) {

        self._isAnimating = isAnimating
        self.style = style
        self.configuration = configuration
    }

    public func makeUIView(
        context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        
        UIActivityIndicatorView(style: style)
    }

    public func updateUIView(
        _ uiView: UIActivityIndicatorView,
        context: UIViewRepresentableContext<ActivityIndicator>) {
        
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}


@available(iOS 13.0, *)
extension View where Self == ActivityIndicator {
    
    public func configure(
        _ configuration: @escaping (UIActivityIndicatorView) -> Void) -> Self {
        
        Self.init(
            isAnimating: self.$isAnimating,
            style: self.style,
            configuration: configuration
        )
    }
}


@available(iOS 13.0, *)
struct ActivityIndicator_Preview: PreviewProvider {

    static var previews: some View {
        ActivityIndicator(isAnimating: .constant(true), style: .medium)
            .configure { $0.color = .red }
    }
}

#endif
