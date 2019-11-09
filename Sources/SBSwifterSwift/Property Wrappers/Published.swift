import Foundation
import Combine

@available(iOS 13.0, macOS 10.15, *)
private var cancellables = [String : AnyCancellable]()

@available(iOS 13.0, macOS 10.15, *)
extension Published {
    
    public init(wrappedValue value: Value, key: String, defaults: UserDefaults = .standard) {
        
        let value = defaults.object(forKey: key) as? Value ?? value
        self.init(initialValue: value)
        cancellables[key] = projectedValue.sink { val in
            defaults.set(val, forKey: key)
        }
    }
}
