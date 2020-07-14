import Foundation

extension NSObjectProtocol {
    
    /// Create (if necessary) and return a thread singleton instance of the object you want.
    ///
    /// Use this method to create objects that are expensive to initialize like Formatters.
    /// - Parameter key: The identifier of the object.
    /// - Parameter create: The create routine used the first time you are about to create the object in thread.
    /// - Returns: An instance of the object for the caller's thread.
    public static func threadSharedObject<T: AnyObject>(key: String, create: () -> T) -> T {
        if let cachedObject = Thread.current.threadDictionary[key] as? T { return cachedObject }
        else {
            let newObject = create()
            Thread.current.threadDictionary[key] = newObject
            return newObject
        }
    }
    
    /// Prints a message to the console that indicates that this object has been deallocated.
    /// Use this method inside an object's `deinit` method.
    @available(*, deprecated, message: "Use Logger instead")
    public func printDeinitMessage() {
        
        print("Deinit " + String(describing: self))
    }
}
