import Foundation

extension NSObjectProtocol {
    
    /// Create (if necessary) and return a thread singleton instance of the object you want.
    ///
    /// Use this method to create objects that are expensive to initialize like Formatters.
    /// - Parameter key: The identifier of the object.
    /// - Parameter create: The create routine used the first time you are about to create the object in thread.
    /// - Returns: An instance of the object for the caller's thread.
    public static func threadSharedObject<T>(key: String, create: () -> T) -> T
    where T: AnyObject {
        if let cachedObject = Thread.current.threadDictionary[key] as? T { return cachedObject }
        else {
            let newObject = create()
            Thread.current.threadDictionary[key] = newObject
            return newObject
        }
    }
}
