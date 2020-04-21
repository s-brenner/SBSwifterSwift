import Foundation

public extension UserDefaults {
    
    /// Get and set objects using subscript.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter key: A key in the current user‘s defaults database.
    subscript(key: String) -> Any? {
        get { object(forKey: key) }
        set { set(newValue, forKey: key) }
    }
    
    /// Returns the float associated with the specified key.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter key: A key in the current user‘s defaults database.
    /// - Returns: The float associated with the specified key, or `nil` if the key was not found.
    func float(forKey key: String) -> Float? {
        
        self[key] as? Float
    }
    
    /// Returns the date associated with the specified key.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter key: A key in the current user‘s defaults database.
    /// - Returns: The date associated with the specified key, or `nil` if the key was not found.
    func date(forKey key: String) -> Date? {
        
        self[key] as? Date
    }
    
    /// Returns the codable object associated with the specified key.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter type: Object that conforms to the Codable protocol.
    /// - Parameter key: A key in the current user's defaults database.
    /// - Parameter decoder: JSONDecoder used to decode the data in the user's defaults database.
    /// - Returns: The codable object associated with the specified key, or `nil` if the key was not found.
    func object<T: Codable>(_ type: T.Type, forKey key: String, usingDecoder decoder: JSONDecoder = .init()) -> T? {
        
        guard let data = value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    /// Sets the value of the specified default key.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter object: The object to store in the defaults database.
    /// - Parameter key: The key with which to associate the value.
    /// - Parameter encoder: JSONEncoder used to encode the object.
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = .init()) {
        
        self[key] = try? encoder.encode(object)
    }
}
