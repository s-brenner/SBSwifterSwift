#if canImport(UIKit) && os(iOS)
import UIKit

@available(iOS 13.0, *)
extension UITableViewDiffableDataSource {
    
    public typealias Snapshot = NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>

    /// Returns an empty snapshot.
    public func emptySnapshot() -> Snapshot { .init() }
}
#endif
