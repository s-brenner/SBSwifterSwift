#if canImport(UIKit)
import UIKit

@available(iOS 13.0, *)
extension UITableViewDiffableDataSource {
    
    /// Returns an empty snapshot.
    public func emptySnapshot() -> NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType> {
        
        .init()
    }
}
#endif
