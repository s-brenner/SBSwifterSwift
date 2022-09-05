#if canImport(SwiftUI)
import SwiftUI

fileprivate struct ShareSheetViewModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    
    let activityItems: [Any]
    
    var applicationActivities: [UIActivity]?
    
    var excludedActivityTypes: [UIActivity.ActivityType]?
    
    var callback: UIActivityViewController.CompletionWithItemsHandler?
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                ShareSheetView(
                    activityItems: activityItems,
                    applicationActivities: applicationActivities,
                    excludedActivityTypes: excludedActivityTypes,
                    callback: callback
                )
            }
    }
}

fileprivate struct ShareSheetView: UIViewControllerRepresentable {
    
    let activityItems: [Any]
    
    var applicationActivities: [UIActivity]?
    
    var excludedActivityTypes: [UIActivity.ActivityType]?
    
    var callback: UIActivityViewController.CompletionWithItemsHandler?
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) { }
}

extension View {
    
    public func shareSheet(
        isPresented: Binding<Bool>,
        activityItems: [Any],
        applicationActivities: [UIActivity]? = nil,
        excludedActivityTypes: [UIActivity.ActivityType]? = nil,
        callback: UIActivityViewController.CompletionWithItemsHandler? = nil
    ) -> some View {
        modifier(
            ShareSheetViewModifier(
                isPresented: isPresented,
                activityItems: activityItems,
                applicationActivities: applicationActivities,
                excludedActivityTypes: excludedActivityTypes,
                callback: callback
            )
        )
    }
}
#endif
