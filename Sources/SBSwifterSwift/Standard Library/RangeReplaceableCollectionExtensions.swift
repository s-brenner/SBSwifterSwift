import Foundation

extension RangeReplaceableCollection where Element: Hashable {
    
    /// Removes the given elements from the collection.
    /// - Complexity: O(n), where n is the length of the collection.
    /// - Parameter elements: The elements to remove.
    /// - Author: Scott Brenner | SBSwifterSwift
    public mutating func removeAll(_ elements: Set<Element>) {
        self.removeAll(where: { elements.contains($0) })
    }
    
    /// Returns a collection with the given elements removed.
    /// - Complexity: O(n), where n is the length of the collection.
    /// - Parameter elements: The elements to remove.
    /// - Returns: A collection without the given elements.
    /// - Author: Scott Brenner | SBSwifterSwift
    public func removingAll(_ elements: Set<Element>) -> Self {
        var collection = self
        collection.removeAll(elements)
        return collection
    }
}

extension RangeReplaceableCollection {
    
    /// Safely accesses the element at the specified position.
    /// - Parameter index: The position of the element to access.
    /// - Returns: The element of the collection at the specified position or `nil` if the position is invalid.
    /// - Complexity: O(1)
    /// - Author: Scott Brenner | SBSwifterSwift
    public func get(at index: Index) -> Element? {
        guard index >= startIndex, index < endIndex else { return nil }
        return self[index]
    }
    
    /// Returns a collection with the new element added to the end.
    ///
    /// If the collection does not have sufficient capacity for another element, additional storage is allocated before appending `newElement`.
    /// - Parameter newElement: The element to append to the collection.
    /// - Returns: A collection with the new element added to the end. If the new element is `nil`, the original collection is returned.
    /// - Complexity: O(1) on average, over many calls to appending(_:) on the same collection.
    /// - Author: Scott Brenner | SBSwifterSwift
    public func appending(_ newElement: Element?) -> Self {
        guard let newElement else { return self }
        var collection = self
        collection.append(newElement)
        return collection
    }
    
    /// Returns a collection with the new elements added to the end.
    ///
    /// If the collection does not have sufficient capacity for the additional elements, additional storage is allocated before appending `newElements`.
    /// - Parameter newElements: The elements to append to the collection.
    /// - Returns: A collection with the new elements added to the end.
    /// - Complexity: O(1) on average, over many calls to appending(_:) on the same collection.
    /// - Author: Scott Brenner | SBSwifterSwift
    public func appending(_ newElements: Self) -> Self {
        self + newElements
    }
}
