#if os(iOS) || os(macOS) || os(watchOS)
public final class CompoundPredicate<Root>: NSCompoundPredicate, TypedPredicateProtocol { }

public func && <TP1, TP2>(p1: TP1, p2: TP2) -> CompoundPredicate<TP1.Root>
where TP1: TypedPredicateProtocol,
      TP2: TypedPredicateProtocol,
      TP1.Root == TP2.Root {
    CompoundPredicate(type: .and, subpredicates: [p1, p2])
}

public func || <TP1, TP2>(p1: TP1, p2: TP2) -> CompoundPredicate<TP1.Root>
where TP1: TypedPredicateProtocol,
      TP2: TypedPredicateProtocol,
      TP1.Root == TP2.Root {
    CompoundPredicate(type: .or, subpredicates: [p1, p2])
}

public prefix func ! <TP>(p: TP) -> CompoundPredicate<TP.Root>
where TP: TypedPredicateProtocol {
    CompoundPredicate(type: .not, subpredicates: [p])
}
#endif
