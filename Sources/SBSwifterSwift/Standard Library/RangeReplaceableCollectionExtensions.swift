import Foundation

public extension RangeReplaceableCollection where Element: Hashable {
    
    /// Removes the given elements from the collection.
    /// - Complexity: O(n), where n is the length of the collection.
    /// - Parameter elements: The elements to remove.
    mutating func removeAll(_ elements: Set<Element>) {
        self.removeAll(where: { elements.contains($0) })
    }
    
    /// Returns a collection with the given elements removed.
    /// - Complexity: O(n), where n is the length of the collection.
    /// - Parameter elements: The elements to remove.
    /// - Returns: A collection without the given elements.
    func removingAll(_ elements: Set<Element>) -> Self {
        var collection = self
        collection.removeAll(elements)
        return collection
    }
}
