#if canImport(BackgroundTasks) && canImport(SwiftUI)
import BackgroundTasks
import struct SwiftUI.BackgroundTask

extension BGTaskRequest {
    
    public struct Identifier: RawRepresentable {
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension BGAppRefreshTaskRequest {
    
    public convenience init(identifier: Identifier) {
        self.init(identifier: identifier.rawValue)
    }
}

@available(iOS 16.0, *)
extension BackgroundTask
where Request == Void, Response == Void {
    
    public static func appRefresh(_ identifier: BGTaskRequest.Identifier) -> BackgroundTask<Void, Void> {
        appRefresh(identifier.rawValue)
    }
}
#endif
