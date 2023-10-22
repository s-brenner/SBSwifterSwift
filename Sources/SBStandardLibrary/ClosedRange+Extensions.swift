import Foundation

extension ClosedRange {
    
    public static func ~=(lhs: Self, rhs: Self) -> Bool {
        rhs.clamped(to: lhs) == rhs
    }
}
