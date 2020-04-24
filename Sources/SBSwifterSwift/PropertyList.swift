import Foundation

public enum PropertyList {
    
    /// Returns the dictionary for the .plist file identified by the specified name.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter name: The name of the resource .plist file.
    /// - Parameter bundle: The bundle in which the file is contained.
    /// - Returns: The dictionary for the .plist file or an empty dictionary if the resource could not be parsed.
    public static func named(_ name: String, inBundle bundle: Bundle = .main) -> [String: Any] {
        
        do {
            guard let path = bundle.path(forResource: name, ofType: "plist") else { return [:] }
            guard let xml = FileManager.default.contents(atPath: path) else { return [:] }
            var format = PropertyListSerialization.PropertyListFormat.xml
            let list = try PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: &format)
            return list as? [String: Any] ?? [:]
        }
        catch {
            NSLog(error.localizedDescription)
            return [:]
        }
    }
    
    public enum Info {
        
        public static let list = PropertyList.named("Info")
        
        public static let name =  list["CFBundleDisplayName"] as? String ?? ""
        
        public static let version = list["CFBundleShortVersionString"] as? String ?? ""
        
        public static let build = list["CFBundleVersion"] as? String ?? ""
    }
}
