#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public struct Wrap<Wrapped: UIView>: UIViewRepresentable {
    
    public typealias Updater = (Wrapped, Context) -> Void

    var makeView: () -> Wrapped
    
    var update: Updater

    public func makeUIView(context: Context) -> Wrapped {
        
        makeView()
    }

    public func updateUIView(_ view: Wrapped, context: Context) {
        
        update(view, context)
    }
}

public extension Wrap {
    
    init(_ makeView: @escaping @autoclosure () -> Wrapped,
         updater update: @escaping Updater) {
        
        self.makeView = makeView
        self.update = update
    }
    
    init(_ makeView: @escaping @autoclosure () -> Wrapped,
         updater update: @escaping (Wrapped) -> Void) {
        
        self.makeView = makeView
        self.update = { view, _ in update(view) }
    }

    init(_ makeView: @escaping @autoclosure () -> Wrapped) {
        
        self.makeView = makeView
        self.update = { _, _ in }
    }
}

#endif
