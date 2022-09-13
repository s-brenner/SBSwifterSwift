#if canImport(UIKit) && os(iOS)

import UIKit

extension UISegmentedControl {
    
    public var segmentIndexPublisher: AnyPublisher<Int, Never> {
        publisher(for: .valueChanged)
            .map { self.selectedSegmentIndex }
            .eraseToAnyPublisher()
    }
}
#endif
