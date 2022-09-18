#if canImport(SwiftUI) && os(iOS)
import SwiftUI

@available(iOS, introduced: 13.0, obsoleted: 16.0, message: "Use ShareLink instead")
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

@available(iOS, introduced: 13.0, obsoleted: 16.0, message: "Use ShareLink instead")
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
    
    @available(iOS, introduced: 13.0, obsoleted: 16.0, message: "Use ShareLink instead")
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
