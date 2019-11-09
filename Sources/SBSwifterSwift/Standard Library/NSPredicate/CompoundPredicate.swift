import Foundation

public final class CompoundPredicate<Root>: NSCompoundPredicate, TypedPredicateProtocol {}


// MARK: - Compound Operators

public func && <TP1: TypedPredicateProtocol, TP2: TypedPredicateProtocol>(p1: TP1, p2: TP2) ->
    CompoundPredicate<TP1.Root> where TP1.Root == TP2.Root {
        
        CompoundPredicate(type: .and, subpredicates: [p1, p2])
}

public func || <TP1: TypedPredicateProtocol, TP2: TypedPredicateProtocol>(p1: TP1, p2: TP2) ->
    CompoundPredicate<TP1.Root> where TP1.Root == TP2.Root {
        
        CompoundPredicate(type: .or, subpredicates: [p1, p2])
}

public prefix func ! <TP: TypedPredicateProtocol>(p: TP) -> CompoundPredicate<TP.Root> {
    
    CompoundPredicate(type: .not, subpredicates: [p])
}
