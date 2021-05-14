//#if canImport(SwiftUI) && os(iOS)
//import SwiftUI
//
//struct BottomSheetView<Primary, BottomSheet>: View
//where Primary: View, BottomSheet: View {
//
//    private let primary: Primary
//
//    private let bottomSheet: BottomSheet
//
//    @State private var offset: CGFloat = 0
//
//    init(
//        @ViewBuilder _ primary: () -> Primary,
//        @ViewBuilder bottomSheet: () -> BottomSheet
//    ) {
//        self.primary = primary()
//        self.bottomSheet = bottomSheet()
//    }
//
//    var body: some View {
//        ZStack(alignment: .init(horizontal: .center, vertical: .bottom)) {
//            primary
//                .legacyIgnoresSafeArea()
//            GeometryReader { reader in
//                VStack {
//                    SheetContainer(content: bottomSheet)
//                        .offset(y: reader.frame(in: .global).height - 140)
//                        .offset(y: offset)
//                        .gesture(dragGesture(proxy: reader))
//                }
//            }
//            .legacyIgnoresSafeArea(.bottom)
//        }
//    }
//}
//
//private extension BottomSheetView {
//
//    struct SheetContainer<Content>: View
//    where Content: View {
//
//        let content: Content
//
//        var body: some View {
//            VStack {
//                Capsule()
//                    .fill(Color.gray.opacity(0.5))
//                    .frame(width: 50, height: 5)
//                    .padding(.top)
//                    .padding(.bottom, 5)
//                content
//            }
//            .background(BlurView(style: .systemMaterial))
//            .cornerRadius(15)
//        }
//    }
//
//    struct BlurView: UIViewRepresentable {
//
//        let style: UIBlurEffect.Style
//
//        func makeUIView(context: Context) -> UIVisualEffectView {
//            UIVisualEffectView(effect: UIBlurEffect(style: style))
//        }
//
//        func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
//    }
//
//    func dragGesture(proxy: GeometryProxy) -> some Gesture {
//        DragGesture()
//            .onChanged { value in
////                print("t: \(value.translation.height), o: \(offset)")
//                if value.isScrollingUp(relativeTo: proxy) {
//                    if value.translation.height < 0 &&
//                        offset > -proxy.frame(in: .global).height + 150 {
//                        offset = value.translation.height
//                    }
//                }
//                if value.isScrollingDown(relativeTo: proxy) {
//                    if value.translation.height > 0 && offset < 0 {
//                        offset = value.translation.height - proxy.frame(in: .global).height + 150
//                    }
//                }
//            }
//            .onEnded { value in
//                withAnimation {
//                    if value.isScrollingUp(relativeTo: proxy) {
//                        if value.isMoreThanHalfway(relativeTo: proxy) {
//                            offset = -proxy.frame(in: .global).height + 150
//                        } else {
//                            offset = 0
//                        }
//                    }
//                    if value.isScrollingDown(relativeTo: proxy) {
//                        if value.isPoop2(relativeTo: proxy) {
//                            offset = -proxy.frame(in: .global).height + 150
//                        } else {
//                            offset = 0
//                        }
//                    }
//                }
//            }
//    }
//}
//
//extension DragGesture.Value {
//
//    func isScrollingUp(relativeTo proxy: GeometryProxy) -> Bool {
//        startLocation.y > proxy.frame(in: .global).midX
//    }
//
//    func isScrollingDown(relativeTo proxy: GeometryProxy) -> Bool {
//        startLocation.y < proxy.frame(in: .global).midX
//    }
//
//    func isMoreThanHalfway(relativeTo proxy: GeometryProxy) -> Bool {
//        -translation.height > proxy.frame(in: .global).midX
//    }
//
//    func isPoop2(relativeTo proxy: GeometryProxy) -> Bool {
//        translation.height < proxy.frame(in: .global).midX
//    }
//}
//
//struct BottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomSheetView {
//            Text("Home")
//        } bottomSheet: {
//            Text("Sheet")
//        }
//    }
//}
//
//@available(iOS, introduced: 13, deprecated: 14, message: "Use ignoresSafeArea directly")
//struct LegacyIgnoringSafeArea: ViewModifier {
//
//    private let edges: Edge.Set
//
//    init(_ edges: Edge.Set = .all) {
//        self.edges = edges
//    }
//
//    func body(content: Content) -> some View {
//        if #available(iOS 14, *) {
//            return content
//                .ignoresSafeArea(.all, edges: edges)
//                .eraseToAnyView()
//        } else {
//            return content
//                .edgesIgnoringSafeArea(edges)
//                .eraseToAnyView()
//        }
//    }
//}
//
//extension View {
//
//    @available(iOS, introduced: 13, deprecated: 14, message: "Use ignoresSafeArea directly")
//    func legacyIgnoresSafeArea(_ edges: Edge.Set = .all) -> some View {
//        modifier(LegacyIgnoringSafeArea(edges))
//    }
//}
//#endif
