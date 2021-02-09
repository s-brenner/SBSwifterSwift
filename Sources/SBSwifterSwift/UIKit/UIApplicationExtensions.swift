#if canImport(UIKit)
import UIKit

extension UIApplication {
    
    /// Application name (if applicable).
    public static var displayName: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    /// App's current build number (if applicable).
    public static var buildNumber: String? {
        Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    /// App's current version number (if applicable).
    public static var version: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
#endif
