#if os(iOS) || os(macOS) || os(watchOS)
public protocol TypedPredicateProtocol: NSPredicate {
    
    associatedtype Root
}
#endif
