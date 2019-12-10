//import Foundation
//
//public struct Predicate<Target> {
//
//    public var matches: (Target) -> Bool
//
//    public init(matcher: @escaping (Target) -> Bool) {
//        matches = matcher
//    }
//}
//
//public func ==<T, V: Equatable>(lhs: KeyPath<T, V>, rhs: V) -> Predicate<T> {
//
//    Predicate { $0[keyPath: lhs] == rhs }
//}
//
//public prefix func !<T>(rhs: KeyPath<T, Bool>) -> Predicate<T> {
//
//    rhs == false
//}
//
//public func ><T, V: Comparable>(lhs: KeyPath<T, V>, rhs: V) -> Predicate<T> {
//    
//    Predicate { $0[keyPath: lhs] > rhs }
//}
//
//public func <<T, V: Comparable>(lhs: KeyPath<T, V>, rhs: V) -> Predicate<T> {
//
//    Predicate { $0[keyPath: lhs] < rhs }
//}
//
//public func >=<T, V: Comparable>(lhs: KeyPath<T, V>, rhs: V) -> Predicate<T> {
//
//    Predicate { $0[keyPath: lhs] >= rhs }
//}
//
//public func <=<T, V: Comparable>(lhs: KeyPath<T, V>, rhs: V) -> Predicate<T> {
//
//    Predicate { $0[keyPath: lhs] <= rhs }
//}
//
//public func &&<T>(lhs: Predicate<T>, rhs: Predicate<T>) -> Predicate<T> {
//
//    Predicate { lhs.matches($0) && rhs.matches($0) }
//}
//
//public func ||<T>(lhs: Predicate<T>, rhs: Predicate<T>) -> Predicate<T> {
//
//    Predicate { lhs.matches($0) || rhs.matches($0) }
//}
