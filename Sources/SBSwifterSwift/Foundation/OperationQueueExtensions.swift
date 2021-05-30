import Foundation

public extension OperationQueue {
    
    ///- Author: Scott Brenner | SBSwifterSwift
    static func serialQueue(named name: String? = nil, qualityOfService: QualityOfService = .default) -> OperationQueue {
        let queue = OperationQueue()
        queue.name = name
        queue.qualityOfService = qualityOfService
        queue.maxConcurrentOperationCount = 1
        return queue
    }
}
