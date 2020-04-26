import Foundation

extension Sequence {
    
    /// Returns the sum of the values of a given numeric property within this sequence.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n), where n is the length of the sequence.
    /// - Parameter keyPath: The numeric property to sum.
    /// - Returns: The sum of the values of a given numeric property within this sequence.
    public func sum<T: Numeric>(for keyPath: KeyPath<Element, T>) -> T {
        
        reduce(0) { sum, element in
            sum + element[keyPath: keyPath]
        }
    }
    
    /// Returns an array containing the results of mapping the given property over the sequence’s elements.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n), where n is the length of the sequence.
    /// - Parameter keyPath: The property to map.
    /// - Returns: An array of the results of mapping the given property over the this sequence's elements.
    public func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        
        map { $0[keyPath: keyPath] }
    }
    
    /// Returns the elements of the sequence sorted according to any comparable property.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n log n), where n is the length of the sequence.
    /// - Parameter keyPath: The comparable property by which to sort to the sequence.
    /// - Parameter ascending: The order in which to sort the sequence.
    /// - Returns: An array of sorted elements.
    public func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        
        sorted { a, b in
            let aa = a[keyPath: keyPath]
            let bb = b[keyPath: keyPath]
            return ascending ? aa < bb : aa > bb
        }
    }
    
    /// Returns a Boolean value indicating whether every element of a given sequence contains an element that satisfies the matcher.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n log n), where n is the length of the sequence.
    /// - Parameter values: x.
    /// - Parameter matcher: x.
    /// - Returns: `true` if the sequence contains only elements matched by the matcher; otherwise, `false`.
    public func contains<T: Sequence>(_ values: T, matchedBy matcher: (Element, T.Element) -> Bool) -> Bool {
        
        values.allSatisfy { value in
            contains(where: { matcher($0, value) })
        }
    }
}
