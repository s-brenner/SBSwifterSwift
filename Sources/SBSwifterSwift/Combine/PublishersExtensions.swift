import Combine
import Foundation

extension Publishers {
    
    class DownloadSubscription<S: Subscriber>: NSObject, Subscription, URLSessionDownloadDelegate
    where S.Input == (progress: Float, data: Data?), S.Failure == URLError {
        
        private lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        private let request: URLRequest
        
        private var subscriber: S?
        
        private var progress: Float = 0
        
        private let totalBytesExpected: Int64
        
        init(request: URLRequest, subscriber: S, totalBytesExpected: Int64) {
            
            self.request = request
            self.subscriber = subscriber
            self.totalBytesExpected = totalBytesExpected
            super.init()
            session.downloadTask(with: request).resume()
        }
        
        func request(_ demand: Subscribers.Demand) { }
        
        func cancel() {
            
            subscriber = nil
            session.invalidateAndCancel()
        }
        
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            
            guard let data = try? Data(contentsOf: location) else { return }
            _ = subscriber?.receive((progress: progress, data: data))
            subscriber?.receive(completion: .finished)
            session.invalidateAndCancel()
        }
        
        func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
            
            guard let error = error as? URLError else { return }
            subscriber?.receive(completion: .failure(error))
            session.invalidateAndCancel()
        }
        
        func urlSession(
            _ session: URLSession,
            downloadTask: URLSessionDownloadTask,
            didWriteData bytesWritten: Int64,
            totalBytesWritten: Int64,
            totalBytesExpectedToWrite: Int64) {
            
            let total = totalBytesExpectedToWrite == -1 ? totalBytesExpected : totalBytesExpectedToWrite
            progress = total == -1 ? 0 : Float(totalBytesWritten) / Float(total)
            _ = subscriber?.receive((progress: progress, data: nil))
        }
    }
    
    public struct DownloadPublisher: Publisher {
        
        public typealias Output = (progress: Float, data: Data?)
        
        public typealias Failure = URLError
        
        private let request: URLRequest
        
        private let totalBytesExpected: Int64
        
        init(request: URLRequest, totalBytesExpected: Int64 = -1) {
            
            self.request = request
            self.totalBytesExpected = totalBytesExpected
        }
        
        public func receive<S>(subscriber: S)
            where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
                
                let subscription = DownloadSubscription(
                    request: request,
                    subscriber: subscriber,
                    totalBytesExpected: totalBytesExpected
                )
                subscriber.receive(subscription: subscription)
        }
    }
}


public extension URLSession {
    
    static func downloadPublisher(
        for request: URLRequest,
        totalBytesExpected total: Int64 = -1) -> Publishers.DownloadPublisher {
        
        .init(request: request, totalBytesExpected: total)
    }
}
