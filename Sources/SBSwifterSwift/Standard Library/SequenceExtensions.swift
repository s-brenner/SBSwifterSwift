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
    
    /// Returns an array containing the `non-nil`elements  of this sequence.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(m + n), where n is the length of this sequence and m is the length of the result.
    /// - Returns: An array containing the `non-nil`elements  of this sequence.
    public func compact<T>() -> [T] where Element == Optional<T> {
        compactMap { $0 }
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
    
    /// Returns a Boolean value indicating whether every element of a given sequence contains an element of the receiver that satisfies the matcher.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n * m), where n and m are the lengths of the sequences.
    /// - Parameter values: The given sequence.
    /// - Parameter matcher: A function that compares an element of the receiver to an element of the given sequence.
    /// - Parameter element: An element of the receiver sequence.
    /// - Parameter valuesElement: An element of the provided sequence.
    /// - Returns: `true` if the sequence contains only elements matched by the matcher; otherwise, `false`.
    public func contains<T: Sequence>(
        _ values: T,
        matchedBy matcher: (_ element: Element, _ valuesElement: T.Element) -> Bool
    ) -> Bool {
        values.allSatisfy { value in
            contains(where: { matcher($0, value) })
        }
    }
    
    /// Returns the count of elements that should be counted based on the given closure.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter shouldBeCounted: A closure that determines if a given element should be counted.
    /// - Parameter element: The element of the sequence.
    /// - Returns: The count of elements that satisfy the given closure.
    /// - Complexity: O(n), where n is the length of the sequence.
    /// - Note: Based on `reduce(_:_:)`.
    public func count(where shouldBeCounted: (_ element: Element) throws -> Bool) rethrows -> Int {
        try reduce(0) {
            let additive = try shouldBeCounted($1) ? 1 : 0
            return $0 + additive
        }
    }
    
    public func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var values = [T]()
        for element in self {
            try await values.append(transform(element))
        }
        return values
    }
    
    public func concurrentMap<T>(_ transform: @escaping (Element) async throws -> T) async throws -> [T] {
        let tasks = map { element in
            Task { try await transform(element) }
        }
        return try await tasks.asyncMap { task in
            try await task.value
        }
    }
    
    public func asyncForEach(_ operation: (Element) async throws -> Void) async rethrows {
        for element in self {
            try await operation(element)
        }
    }
}
