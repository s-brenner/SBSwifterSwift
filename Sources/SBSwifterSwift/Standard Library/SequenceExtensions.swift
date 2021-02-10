import Foundation

public extension Sequence {
    
    /// Returns the sum of the values of a given numeric property within this sequence.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n), where n is the length of the sequence.
    /// - Parameter keyPath: The numeric property to sum.
    /// - Returns: The sum of the values of a given numeric property within this sequence.
    func sum<T: Numeric>(for keyPath: KeyPath<Element, T>) -> T {
        reduce(0) { sum, element in
            sum + element[keyPath: keyPath]
        }
    }
    
    /// Returns an array containing the results of mapping the given property over the sequence’s elements.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n), where n is the length of the sequence.
    /// - Parameter keyPath: The property to map.
    /// - Returns: An array of the results of mapping the given property over the this sequence's elements.
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        map { $0[keyPath: keyPath] }
    }
    
    /// Returns the elements of the sequence sorted according to any comparable property.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n log n), where n is the length of the sequence.
    /// - Parameter keyPath: The comparable property by which to sort to the sequence.
    /// - Parameter ascending: The order in which to sort the sequence.
    /// - Returns: An array of sorted elements.
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        sorted { a, b in
            let aa = a[keyPath: keyPath]
            let bb = b[keyPath: keyPath]
            return ascending ? aa < bb : aa > bb
        }
    }
    
    /// Returns a Boolean value indicating whether every element of a given sequence contains an element of the receiver that satisfies the matcher.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n * m), where n and m are the lengths of the sequences.
    /// - Parameter values: The given sequence.
    /// - Parameter matcher: A function that compares an element of the receiver to an element of the given sequence.
    /// - Parameter element: An element of the receiver sequence.
    /// - Parameter valuesElement: An element of the provided sequence.
    /// - Returns: `true` if the sequence contains only elements matched by the matcher; otherwise, `false`.
    func contains<T: Sequence>(
        _ values: T,
        matchedBy matcher: (_ element: Element, _ valuesElement: T.Element) -> Bool
    ) -> Bool {
        values.allSatisfy { value in
            contains(where: { matcher($0, value) })
        }
    }
}
