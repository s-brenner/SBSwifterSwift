#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS)
public extension CaseIterable where AllCases.Element: Equatable {
    
    /// Returns the next element in the array of all cases.
    /// - Returns: The next element, looping to the beginning if needed.
    ///- Author: Scott Brenner | SBSwifterSwift
    func next() -> Self {
        let index = Self.allCases.firstIndex(of: self)!
        var nextIndex = Self.allCases.index(after: index)
        if nextIndex == Self.allCases.endIndex {
            nextIndex = Self.allCases.startIndex
        }
        return Self.allCases[nextIndex]
    }
}
#endif
