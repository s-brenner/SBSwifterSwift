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
    public var overlappingPairs: [[Element]] {
        return stride(from: 0, to: count - 1, by: 1)
            .map { [ self[$0], self[$0 + 1] ] }
    }
}


extension Array where Element: Equatable {
    
    /// Remove all duplicate elements.
    /// ````
    /// [1, 2, 2, 3, 3, 4].removeDuplicates() -> [1, 2, 3, 4]
    /// ````
    /// - Returns: Array with all duplicate elements removed.
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
    /// - Returns: Array of unique elements.
    public func withoutDuplicates() -> [Element] {
        return reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
}
