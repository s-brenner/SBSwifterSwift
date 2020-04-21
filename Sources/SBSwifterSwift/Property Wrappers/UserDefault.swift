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
    public private(set) var defaultValue: DefaultValue
    
    /// The wrapped value.
    public var wrappedValue: T {
        get { defaults.object(T.self, forKey: key) ?? defaultValue() }
        set { defaults.set(object: newValue, forKey: key) }
    }
    
    /// The projected value.
    public var projectedValue: UserDefault<T> { self }
        
    
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


extension UserDefault where T: Equatable {
    
    /// A Boolean value that describes whether the wrapped value is equal to the default value.
    public var isDefault: Bool { wrappedValue == defaultValue() }
}


extension UserDefault: Equatable {
    
    public static func == (lhs: UserDefault<T>, rhs: UserDefault<T>) -> Bool {
        
        lhs.defaults == rhs.defaults &&
            lhs.key == rhs.key
    }
}
