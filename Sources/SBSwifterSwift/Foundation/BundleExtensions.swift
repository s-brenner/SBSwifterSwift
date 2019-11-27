import Foundation

extension Bundle {
    
    public func decode<T: Decodable>(
        _ type: T.Type,
        from file: String,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        }
        catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        }
        catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        }
        catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        }
        catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        }
        catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
    
    /// Returns the dictionary for the .plist file identified by the specified name.
    /// - Parameter name: The name of the resource .plist file.
    public func propertyList(forResource name: String) -> [String : Any] {
        
        var format = PropertyListSerialization.PropertyListFormat.xml
        
        guard let path = self.path(forResource: name, ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path),
            let propertyList = try? PropertyListSerialization.propertyList(
                from: xml,
                options: .mutableContainersAndLeaves,
                format: &format) else {
                return [:]
        }
        
        return propertyList as? [String : Any] ?? [:]
    }
}
