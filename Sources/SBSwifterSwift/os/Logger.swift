import os

@available(OSX 10.16, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
public extension Logger {
    
    /// Creates a custom logger for logging to a subsystem and category where the subsystem is set to your app's bundle identifier.
    /// - Author: Scott Brenner | SBSwifterSwift
    init(category: String) {
        
        self.init(subsystem: PropertyList.Info.identifier, category: category)
    }
    
    /// - Author: Scott Brenner | SBSwifterSwift
    func logDeinit() {
        
        log("Deinit \(String(describing: self))")
    }
}
