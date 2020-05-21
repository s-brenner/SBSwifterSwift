import Combine
import Foundation

extension Publishers {
    
    class DownloadSubscription<S: Subscriber>: NSObject, Subscription, URLSessionDownloadDelegate
    where S.Input == (progress: Progress?, data: Data?), S.Failure == URLError {
        
        private lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        private let request: URLRequest
        
        private var subscriber: S?
        
        private var progress: Progress?
        
        private let totalBytesExpected: Int64
        
        init(request: URLRequest, subscriber: S, totalBytesExpected: Int64) {
            
            self.request = request
            self.subscriber = subscriber
            self.totalBytesExpected = totalBytesExpected
            super.init()
            let task = session.downloadTask(with: request)
            task.resume()
        }
        
        func request(_ demand: Subscribers.Demand) { }
        
        func cancel() {
            
            subscriber = nil
            progress = nil
            session.invalidateAndCancel()
        }
        
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            
            guard let data = try? Data(contentsOf: location) else { return }
            _ = subscriber?.receive((progress: nil, data: data))
            subscriber?.receive(completion: .finished)
            progress = nil
            session.invalidateAndCancel()
        }
        
        func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
            
            guard let error = error as? URLError else { return }
            subscriber?.receive(completion: .failure(error))
            progress = nil
            session.invalidateAndCancel()
        }
        
        func urlSession(
            _ session: URLSession,
            downloadTask: URLSessionDownloadTask,
            didWriteData bytesWritten: Int64,
            totalBytesWritten: Int64,
            totalBytesExpectedToWrite: Int64) {
            
            let total = totalBytesExpectedToWrite == NSURLSessionTransferSizeUnknown ? totalBytesExpected : totalBytesExpectedToWrite
            if progress == nil {
                progress = Progress(totalUnitCount: total == NSURLSessionTransferSizeUnknown ? 0 : total)
                progress?.completedUnitCount = totalBytesWritten
                _ = subscriber?.receive((progress: progress, data: nil))
            }
            else {
                progress?.completedUnitCount = totalBytesWritten
            }
        }
    }
    
    public struct DownloadPublisher: Publisher {
        
        public typealias Output = (progress: Progress?, data: Data?)
        
        public typealias Failure = URLError
        
        private let request: URLRequest
        
        private let totalBytesExpected: Int64
        
        init(request: URLRequest, totalBytesExpected: Int64 = NSURLSessionTransferSizeUnknown) {
            
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
    
    
    
    
    
    
    
    
    
    
    
    class DataTaskProgressSubscription<S: Subscriber>: Subscription where
        S.Input == (progress: Progress?, result: (data: Data, response: HTTPURLResponse)?),
        S.Failure == URLError {
        
        private let session: URLSession
        
        private let request: URLRequest
        
        private var subscriber: S?
        
        init(session: URLSession, request: URLRequest, subscriber: S) {
            
            self.session = session
            self.request = request
            self.subscriber = subscriber
            
            let task = session.dataTask(with: request) { data, response, error in
                if let data = data,
                    let response = response as? HTTPURLResponse {
                    _ = subscriber.receive((progress: nil, result: (data: data, response: response)))
                    subscriber.receive(completion: .finished)
                    session.invalidateAndCancel()
                }
                else if let error = error as? URLError {
                    subscriber.receive(completion: .failure(error))
                    session.invalidateAndCancel()
                }
            }
            _ = subscriber.receive((progress: task.progress, result: nil))
            task.resume()
        }
        
        func request(_ demand: Subscribers.Demand) { }
        
        func cancel() {
            
            subscriber = nil
            session.invalidateAndCancel()
        }
    }
    
    public struct DataTaskProgressPublisher: Publisher {
        
        public typealias Output = (progress: Progress?, result: (data: Data, response: HTTPURLResponse)?)
        
        public typealias Failure = URLError
        
        private let session: URLSession
        
        private let request: URLRequest
        
        init(session: URLSession, request: URLRequest) {
            
            self.session = session
            self.request = request
        }
        
        public func receive<S>(subscriber: S) where
            S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
                
                let subscription = DataTaskProgressSubscription(session: session, request: request, subscriber: subscriber)
                subscriber.receive(subscription: subscription)
        }
    }
}


public extension URLSession {
    
    static func downloadPublisher(
        for request: URLRequest,
        totalBytesExpected total: Int64 = NSURLSessionTransferSizeUnknown) -> Publishers.DownloadPublisher {
        
        .init(request: request, totalBytesExpected: total)
    }
    
    func dataTaskProgressPublisher(for request: URLRequest) -> Publishers.DataTaskProgressPublisher {
        
        .init(session: self, request: request)
    }
    
    func dataTaskProgressPublisher(for url: URL) -> Publishers.DataTaskProgressPublisher {
        
        .init(session: self, request: .init(url: url))
    }
}
