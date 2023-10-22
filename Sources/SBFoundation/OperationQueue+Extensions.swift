extension OperationQueue {
    
    ///- Author: Scott Brenner | SBFoundation
    public static func serialQueue(named name: String? = nil, qualityOfService: QualityOfService = .default) -> Self {
        let queue = Self()
        queue.name = name
        queue.qualityOfService = qualityOfService
        queue.maxConcurrentOperationCount = 1
        return queue
    }
}
