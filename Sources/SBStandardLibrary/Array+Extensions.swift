import Foundation

extension Array {
    
    /// Returns nested arrays of element pairs
    /// ````
    /// [1, 2, 3].overlappingPairs -> [[1, 2], [2, 3]]
    ///
    /// [1].overlappingPairs -> []
    ///
    /// [Int]().overlappingPairs -> []
    /// ````
    ///- Author: Scott Brenner | SBSwifterSwift
    public var overlappingPairs: [[Element]] {
        stride(from: 0, to: count - 1, by: 1).map { [ self[$0], self[$0 + 1] ] }
    }
    
    /// Insert an element at the beginning of array.
    /// ````
    /// [2, 3, 4, 5].prepend(1) -> [1, 2, 3, 4, 5]
    ///
    /// ["e", "l", "l", "o"].prepend("h") -> ["h", "e", "l", "l", "o"]
    /// ````
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter newElement: Element to insert.
    public mutating func prepend(_ newElement: Element) {
        insert(newElement, at: 0)
    }
    
    /// Returns a sorted array based on an optional keypath.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n log n), where n is the length of the sequence.
    /// - Parameter path: Key path to sort. The key path type must be Comparable.
    /// - Parameter ascending: If order must be ascending.
    /// - Returns: Sorted array based on keyPath.
    public func sorted<T: Comparable>(by path: KeyPath<Element, T?>, ascending: Bool = true) -> [Element] {
        sorted(by: { (lhs, rhs) -> Bool in
            guard let lhsValue = lhs[keyPath: path], let rhsValue = rhs[keyPath: path] else { return false }
            return ascending ? (lhsValue < rhsValue) : (lhsValue > rhsValue)
        })
    }
    
    /// Returns a sorted array based on a keypath.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n log n), where n is the length of the sequence.
    /// - Parameter path: Key path to sort. The key path type must be Comparable.
    /// - Parameter ascending: If order must be ascending.
    /// - Returns: Sorted array based on keyPath.
    func sorted<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        sorted(by: { (lhs, rhs) -> Bool in
            return ascending ? (lhs[keyPath: path] < rhs[keyPath: path]) : (lhs[keyPath: path] > rhs[keyPath: path])
        })
    }
    
    /// Sort the array based on an optional keypath.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n log n), where n is the length of the sequence.
    /// - Parameter path: Key path to sort, must be Comparable.
    /// - Parameter ascending: Whether order is ascending or not.
    /// - Returns: Self after sorting.
    @discardableResult
    mutating func sort<T: Comparable>(by path: KeyPath<Element, T?>, ascending: Bool = true) -> [Element] {
        self = sorted(by: path, ascending: ascending)
        return self
    }
    
    /// Sort the array based on a keypath.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Complexity: O(n log n), where n is the length of the sequence.
    /// - Parameter path: Key path to sort, must be Comparable.
    /// - Parameter ascending: Whether order is ascending or not.
    /// - Returns: Self after sorting.
    @discardableResult
    mutating func sort<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        self = sorted(by: path, ascending: ascending)
        return self
    }
}


extension Array where Element: Equatable {
    
    /// Remove all instances of an item from array.
    /// ````
    /// [1, 2, 2, 3, 4, 5].removeAll(2) -> [1, 3, 4, 5]
    ///
    /// ["h", "e", "l", "l", "o"].removeAll("l") -> ["h", "e", "o"]
    /// ````
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter item: Item to remove.
    /// - Returns: Self after removing all instances of item.
    @discardableResult
    mutating func removeAll(_ item: Element) -> [Element] {
        removeAll(where: { $0 == item })
        return self
    }
    
    /// Remove all instances contained in items parameter from array.
    /// ````
    /// [1, 2, 2, 3, 4, 5].removeAll([2,5]) -> [1, 3, 4]
    ///
    /// ["h", "e", "l", "l", "o"].removeAll(["l", "h"]) -> ["e", "o"]
    /// ````
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter items: Items to remove.
    /// - Returns: Self after removing all instances of all items in given array.
    @discardableResult
    mutating func removeAll(_ items: [Element]) -> [Element] {
        guard !items.isEmpty else { return self }
        removeAll(where: { items.contains($0) })
        return self
    }
    
    /// Remove all duplicate elements.
    /// ````
    /// [1, 2, 2, 3, 3, 4].removeDuplicates() -> [1, 2, 3, 4]
    /// ````
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Returns: Array with all duplicate elements removed.
    /// - Complexity: O(n), where n is the length of the sequence.
    @discardableResult
    public mutating func removeDuplicates() -> [Element] {
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
        return self
    }
    
    /// Return array with all duplicate elements removed.
    /// ````
    /// [1, 1, 2, 2, 3, 3, 3, 4, 5].withoutDuplicates() -> [1, 2, 3, 4, 5])
    /// ````
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Returns: Array of unique elements.
    public func withoutDuplicates() -> [Element] {
        reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
}
