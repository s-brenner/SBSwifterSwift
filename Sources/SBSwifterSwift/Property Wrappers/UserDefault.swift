import Foundation

@propertyWrapper
public struct UserDefault<T: Codable> {
    
    // MARK: - Types
    
    public typealias DefaultValue = () -> T
    
    
    // MARK: - Properties
    
    /// A key in the current user‘s defaults database.
    public let key: String
    
    /// The defaults database.
    public let defaults: UserDefaults
    
    /// The default value.
    var defaultValue: DefaultValue
    
    /// The wrapped value.
    public var wrappedValue: T {
        get {
            guard let data = defaults.object(forKey: key) as? Data,
                let array = try? PropertyListDecoder().decode([T].self, from: data),
                let first = array.first
                else { return defaultValue() }
            return first
        }
        set {
            let data = try! PropertyListEncoder().encode([newValue])
            defaults.set(data, forKey: key)
        }
    }
    
    
    // MARK: - Initializers
    
    /// - Parameter key: The key with which to associate the value.
    /// - Parameter defaultValue: The default value.
    /// - Parameter defaults: The defaults database.
    public init(key: String,
         defaultValue: @autoclosure @escaping DefaultValue,
         defaults: UserDefaults = .standard) {
        
        self.key = "\(Bundle.main.bundleIdentifier!).\(key)"
        self.defaultValue = defaultValue
        self.defaults = defaults
    }
    
    
    // MARK: - Methods
    
    /// Reset the receiver to the default value.
    public mutating func reset() {
        
        wrappedValue = defaultValue()
    }
}
