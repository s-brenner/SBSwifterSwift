#if canImport(UIKit)

import UIKit

public extension UISegmentedControl {
    
    var segmentIndexPublisher: AnyPublisher<Int, Never> {
        publisher(for: .valueChanged)
            .map { self.selectedSegmentIndex }
            .eraseToAnyPublisher()
    }
}

#endif
