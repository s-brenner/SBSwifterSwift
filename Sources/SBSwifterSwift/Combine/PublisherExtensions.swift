import Combine
import Foundation

public extension Publisher where Self.Failure == Never {
    
    func assignWithoutRetain<Root: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
        on object: Root) -> AnyCancellable {
        
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
