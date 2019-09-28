import Foundation
import Combine

@available(iOS 13.0, *)
private var cancellables = [String : AnyCancellable]()

@available(iOS 13.0, *)
extension Published {
    
    public init(wrappedValue value: Value, key: String) {
        
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? value
        self.init(initialValue: value)
        cancellables[key] = projectedValue.sink { value in
            UserDefaults.standard.set(value, forKey: key)
        }
    }
}
