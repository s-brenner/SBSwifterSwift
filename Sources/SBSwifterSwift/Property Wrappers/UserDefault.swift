#if os(iOS) || os(macOS) || os(watchOS)
@propertyWrapper
public struct UserDefault<T: Codable> {
    
    public typealias DefaultValue = () -> T
    
    /// A key in the current user‘s defaults database.
    public let key: String
    
    /// The defaults database.
    public let defaults: UserDefaults
    
    /// The default value.
    public private(set) var defaultValue: DefaultValue
    
    /// The wrapped value.
    public var wrappedValue: T {
        get { defaults.object(T.self, forKey: key, usingDecoder: JSONDecoder()) ?? defaultValue() }
        set {
            defaults.set(object: newValue, forKey: key, usingEncoder: JSONEncoder())
            subject.send(newValue)
        }
    }
    
    private let subject = PassthroughSubject<T, Never>()
    
    /// - Parameter key: The key with which to associate the value.
    /// - Parameter defaultValue: The default value.
    /// - Parameter defaults: The defaults database.
    public init(
        key: String,
        defaultValue: @autoclosure @escaping DefaultValue,
        defaults: UserDefaults = .standard
    ) {
        self.key = "\(Bundle.main.bundleIdentifier!).\(key)"
        self.defaultValue = defaultValue
        self.defaults = defaults
    }
}

public extension UserDefault {
    
    /// A publisher that fires when the wrapped value is modified.
    var publisher: AnyPublisher<T, Never> {
        subject.eraseToAnyPublisher()
    }
    
    /// Reset the receiver to the default value.
    mutating func reset() {
        wrappedValue = defaultValue()
    }
    
    /// The projected value.
    var projectedValue: UserDefault<T> { self }
}


public extension UserDefault where T: Equatable {
    
    /// A Boolean value that describes whether the wrapped value is equal to the default value.
    var isDefault: Bool { wrappedValue == defaultValue() }
}


extension UserDefault: Equatable {
    
    public static func == (lhs: UserDefault<T>, rhs: UserDefault<T>) -> Bool {
        lhs.defaults == rhs.defaults &&
            lhs.key == rhs.key
    }
}
#endif
