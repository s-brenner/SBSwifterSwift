#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UITableViewDataSource {
    
    /// Returns the table cell model at the specified index path.
    /// - Parameters:
    ///   - indexPath: The index path locating the row in the table view.
    ///   - sections: The sections that define the table view content.
    public func cellModel<T>(for indexPath: IndexPath, in sections: [UITableView.Section<T>]) -> T {
        
        sections[indexPath.section].cells[indexPath.row]
    }
}
#endif
