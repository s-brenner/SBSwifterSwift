import Foundation

/// A specialized predicate that you use to compare a keypath to a value.
public final class ComparisonPredicate<Root>: NSComparisonPredicate, TypedPredicateProtocol {
    
    /// Initializes a predicate to a given type formed by combining given keypath and value using a given modifier and options.
    /// - Parameters:
    ///   - keypath: The keypath that will become the left expression.
    ///   - type: The predicate operator type.
    ///   - value: The value that will become the right expression.
    ///   - modifier: The modifier to apply.
    ///   - options: The options to apply.
    /// ````
    /// ComparisonPredicate(\Person.name,
    ///                     .beginsWith,
    ///                     "Sc",
    ///                     options: .caseInsensitive)
    /// ````
    convenience init<V>(_ keypath: KeyPath<Root, V>,
                        _ type: Operator,
                        _ value: V,
                        modifier: Modifier = .direct,
                        options: Options = []) {
        
        self.init(leftExpression: \Root.self == keypath ? .expressionForEvaluatedObject() : .init(forKeyPath: keypath),
                  rightExpression: .init(forConstantValue: value),
                  modifier: modifier,
                  type: type,
                  options: options)
    }
    
    /// Initializes a predicate to a given type formed by combining given keypath and sequence of values using a given modifier and options.
    /// - Parameters:
    ///   - keypath: The keypath that will become the left expression.
    ///   - type: The predicate operator type.
    ///   - values: The sequence that will become the right expression.
    ///   - modifier: The modifier to apply.
    ///   - options: The options to apply.
    /// ````
    /// ComparisonPredicate(\Person.name,
    ///                     .in,
    ///                     ["Scott", "Michelle"],
    ///                     options: .caseInsensitive)
    /// ````
    public convenience init<S: Sequence, K: KeyPath<Root, S.Element>>(_ keypath: K,
                               _ type: Operator,
                               _ values: S,
                               modifier: Modifier = .direct,
                               options: Options = []) {

        self.init(leftExpression: \Root.self == keypath ? .expressionForEvaluatedObject() : .init(forKeyPath: keypath),
                  rightExpression: .init(forConstantValue: values),
                  modifier: modifier,
                  type: type,
                  options: options)
    }
}


// MARK: - Comparison Operators

public func == <E: Equatable, R, K: KeyPath<R, E>>(kp: K, value: E) -> ComparisonPredicate<R> {
    ComparisonPredicate(kp, .equalTo, value)
}

public func != <E: Equatable, R, K: KeyPath<R, E>>(kp: K, value: E) -> ComparisonPredicate<R> {
    ComparisonPredicate(kp, .notEqualTo, value)
}

public func > <C: Comparable, R, K: KeyPath<R, C>>(kp: K, value: C) -> ComparisonPredicate<R> {
    ComparisonPredicate(kp, .greaterThan, value)
}

public func < <C: Comparable, R, K: KeyPath<R, C>>(kp: K, value: C) -> ComparisonPredicate<R> {
    ComparisonPredicate(kp, .lessThan, value)
}

public func <= <C: Comparable, R, K: KeyPath<R, C>>(kp: K, value: C) -> ComparisonPredicate<R> {
    ComparisonPredicate(kp, .lessThanOrEqualTo, value)
}

public func >= <C: Comparable, R, K: KeyPath<R, C>>(kp: K, value: C) -> ComparisonPredicate<R> {
    ComparisonPredicate(kp, .greaterThanOrEqualTo, value)
}

public func === <S: Sequence, R, K: KeyPath<R, S.Element>>(kp: K, values: S) -> ComparisonPredicate<R> where S.Element: Equatable {
    ComparisonPredicate(kp, .in, values)
}
