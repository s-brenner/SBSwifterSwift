import Foundation

public extension Progress {
    
    struct Chunker {
        
        private var remaining: Int
        
        private let chunkSize: Int
        
        /// Will either be the number specified during initialization or that value plus one.
        public let numberOfChunks: Int64
        
        private var currentChunkCounter = 0
        
        public init(total remaining: Int, estimatedChunks chunks: Int) {
            
            assert(remaining >= chunks, "Estimated chunks may not exceeed the total.")
            assert(remaining.isPositive, "Total must exceed zero.")
            assert(chunks.isPositive, "Chunks must exceed zero.")
            
            self.remaining = remaining
            chunkSize = remaining / chunks
            self.numberOfChunks = Int64(remaining % chunks == 0 ? chunks : chunks + 1)
        }
        
        /// Decrements the remaining value by one. Returns `true` if a chunk completes.
        /// - Returns: `true` if a chunk completes as a result of the decrement.
        public mutating func decrementTotal() -> Bool {
            
            currentChunkCounter += 1
            remaining -= 1
            if currentChunkCounter == chunkSize || remaining == 0 {
                currentChunkCounter = 0
                return true
            }
            return false
        }
    }
}
