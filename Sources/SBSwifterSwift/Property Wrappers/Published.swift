import Combine
import Foundation

private var cancellables = [String : AnyCancellable]()

extension Published {
    
    public init(wrappedValue value: Value, key: String, defaults: UserDefaults = .standard) {
        
        let value = defaults.object(forKey: key) as? Value ?? value
        self.init(initialValue: value)
        cancellables[key] = projectedValue.sink { val in
            defaults.set(val, forKey: key)
        }
    }
}
