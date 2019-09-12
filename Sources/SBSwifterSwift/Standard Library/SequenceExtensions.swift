import Foundation

extension Sequence {
    
    /// Returns the sum of the values of a given numeric property within this sequence.
    /// - Parameter keyPath: The numeric property to sum.
    public func sum<T: Numeric>(for keyPath: KeyPath<Element, T>) -> T {
        reduce(0) { sum, element in
            sum + element[keyPath: keyPath]
        }
    }
    
    /// Returns an array containing the results of mapping the given property over the sequence’s elements.
    /// - Parameter keyPath: The property to map.
    public func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        map { $0[keyPath: keyPath] }
    }
    
    /// Returns the elements of the sequence sorted according to any comparable property.
    /// - Parameter keyPath: The comparable property by which to sort to the sequence.
    /// - Parameter ascending: The order in which to sort the sequence.
    public func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        sorted { a, b in
            let aa = a[keyPath: keyPath]
            let bb = b[keyPath: keyPath]
            return ascending ? aa < bb : aa > bb
        }
    }
}

