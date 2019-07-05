#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UITableView {
    
    // MARK: - Properties
    
    /// Index path of the last row in the tableView.
    public var indexPathForLastRow: IndexPath? {
        indexPathForLastRow(inSection: lastSection)
    }
    
    /// Index of the last section in the tableView.
    public var lastSection: Int {
        numberOfSections.isPositive ? numberOfSections - 1 : 0
    }
    
    /// The number of all of the rows in all of the sections of the tableView.
    public var numberOfRows: Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }
    

    // MARK: - Methods

    /// Return the `IndexPath` for the last row in a given section.
    /// - Parameter section: The section in which to get the last row.
    /// - Returns: Optional `IndexPath` for the last row in the section (if applicable).
    public func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard section >= 0 else { return nil }
        guard numberOfRows(inSection: section).isPositive  else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    /// Remove TableFooterView.
    public func removeTableFooterView() {
        tableFooterView = nil
    }
    
    /// Remove TableHeaderView.
    public func removeTableHeaderView() {
        tableHeaderView = nil
    }
    
    /// Scroll to the bottom of the tableView.
    /// - Parameter animated: `true` to animate the scroll; `false` to make the transition immediate.
    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    /// Scroll to the top of the tableView.
    /// - Parameter animated: `true` to animate the scroll; `false` to make the transition immediate.
    public func scrollToTop(animated: Bool = true) {
        setContentOffset(.zero, animated: animated)
    }
    
    /// Dequeue reusable `UITableViewCell` using class name.
    /// - Parameter name: `UITableViewCell` type
    /// - Returns: `UITableViewCell` object with associated class name.
    public func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }
    
    /// Dequeue reusable `UITableViewCell` using class name for indexPath.
    /// - Parameter name: `UITableViewCell` type.
    /// - Parameter indexPath: The index path specifying the location of the cell. Always specify the index path provided to you by your data source object. This method uses the index path to perform additional configuration based on the cell’s position in the table view.
    /// - Returns: `UITableViewCell` object with associated class name.
    public func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }
    
    /// Dequeue reusable `UITableViewHeaderFooterView` using class name.
    /// - Parameter name: `UITableViewHeaderFooterView` type.
    /// - Returns: `UITableViewHeaderFooterView` object with associated class name.
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
        
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewHeaderFooterView for \(String(describing: name)), make sure the view is registered with table view")
        }
        return headerFooterView
    }
    
    /// Register `UITableViewHeaderFooterView` using class name.
    /// - Parameter name: `UITableViewHeaderFooterView` type.
    public func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    /// Register `UITableViewCell` using class name.
    /// - Parameter name: `UITableViewCell` type.
    public func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
    
    /// Check whether `IndexPath` is valid within the tableView.
    /// - Parameter indexPath: An IndexPath to check.
    /// - Returns: Boolean value for valid or invalid IndexPath.
    public func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        indexPath.section < numberOfSections && indexPath.row < numberOfRows(inSection: indexPath.section)
    }
    
    /// Safely scroll to possibly invalid `IndexPath`.
    /// - Parameter indexPath: The target `IndexPath` to which you want to scroll.
    /// - Parameter scrollPosition: A constant that identifies a relative position in the table view (top, middle, bottom) for row when scrolling concludes.
    /// - Parameter animated: `true` if you want to animate the change in position; `false` if it should be immediate.
    public func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard indexPath.section < numberOfSections else { return }
        guard indexPath.row < numberOfRows(inSection: indexPath.section) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
    
}

#endif
