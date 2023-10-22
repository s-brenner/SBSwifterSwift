import Foundation

extension StringProtocol {
    
    public func firstIndex<S>(of string: S, options: String.CompareOptions = []) -> Index?
    where S: StringProtocol {
        range(of: string, options: options)?.lowerBound
    }
    
    public func endIndexOfFirstOccurrence<S>(of string: S, options: String.CompareOptions = []) -> Index?
    where S: StringProtocol {
        range(of: string, options: options)?.upperBound
    }
    
    public func indices<S>(of string: S, options: String.CompareOptions = []) -> [Index]
    where S: StringProtocol {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    
    public func ranges<S>(of string: S, options: String.CompareOptions = []) -> [Range<Index>]
    where S: StringProtocol {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...].range(of: string, options: options) {
            result.append(range)
            startIndex = if range.lowerBound < range.upperBound {
                return range.upperBound
            }
            else {
                return index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
            }
        }
        return result
    }
}
