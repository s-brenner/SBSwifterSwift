#if os(iOS) || os(macOS) || os(watchOS)
extension UserDefaults {
    
    /// Get and set objects using subscript.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter key: A key in the current user‘s defaults database.
    public subscript(key: String) -> Any? {
        get { object(forKey: key) }
        set { set(newValue, forKey: key) }
    }
    
    /// Returns the float associated with the specified key.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter key: A key in the current user‘s defaults database.
    /// - Returns: The float associated with the specified key, or `nil` if the key was not found.
    public func float(forKey key: String) -> Float? {
        self[key] as? Float
    }
    
    /// Returns the date associated with the specified key.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter key: A key in the current user‘s defaults database.
    /// - Returns: The date associated with the specified key, or `nil` if the key was not found.
    public func date(forKey key: String) -> Date? {
        self[key] as? Date
    }
}
#endif

#if canImport(Combine)
import Combine

#if os(iOS) || os(macOS) || os(watchOS)
extension UserDefaults {
    
    /// Returns the codable object associated with the specified key.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter type: Object that conforms to the Codable protocol.
    /// - Parameter key: A key in the current user's defaults database.
    /// - Parameter decoder: TopLevelDecoder used to decode the data in the user's defaults database.
    /// - Returns: The codable object associated with the specified key, or `nil` if the key was not found.
    public func object<Item, Coder>(_ type: Item.Type, forKey key: String, usingDecoder decoder: Coder) -> Item?
    where Item: Decodable, Coder: TopLevelDecoder, Coder.Input == Data {
        guard let data = value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    /// Sets the value of the specified default key.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter object: The object to store in the defaults database.
    /// - Parameter key: The key with which to associate the value.
    /// - Parameter encoder: TopLevelEncoder used to encode the object.
    public func set<Item, Coder>(object: Item, forKey key: String, usingEncoder encoder: Coder)
    where Item: Encodable, Coder: TopLevelEncoder, Coder.Output == Data {
        self[key] = try? encoder.encode(object)
    }
}
#endif

#endif
