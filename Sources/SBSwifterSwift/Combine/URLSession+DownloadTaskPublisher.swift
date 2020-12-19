import Combine
import Foundation

public extension URLSession {
    
    struct DownloadTaskPublisher: Publisher {
        
        public enum Output {
            case downloading(progress: Double, bytesExpected: Int)
            case finished(url: URL)
        }
        
        public typealias Failure = URLError
        
        private let request: URLRequest
        
        init(request: URLRequest) {
            self.request = request
        }
        
        public func receive<S>(subscriber: S)
        where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = Inner(request: request, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }
}


private extension URLSession.DownloadTaskPublisher {
    
    class Inner<S>: NSObject, Subscription, URLSessionDownloadDelegate
    where S: Subscriber, S.Input == Output, S.Failure == URLError {
        
        private lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        private let request: URLRequest
        
        private var subscriber: S?
        
        init(request: URLRequest, subscriber: S) {
            self.request = request
            self.subscriber = subscriber
            super.init()
            let task = session.downloadTask(with: request)
            task.resume()
        }
        
        func request(_ demand: Subscribers.Demand) { }
        
        func cancel() {
            subscriber = nil
            session.invalidateAndCancel()
        }
        
        func urlSession(
            _ session: URLSession,
            downloadTask: URLSessionDownloadTask,
            didFinishDownloadingTo location: URL
        ) {
            do {
                let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
                let fileURL = cacheDirectory.appendingPathComponent((UUID().uuidString))
                try FileManager.default.moveItem(atPath: location.path, toPath: fileURL.path)
                _ = subscriber?.receive(.finished(url: fileURL))
                subscriber?.receive(completion: .finished)
                session.invalidateAndCancel()
            }
            catch {
                subscriber?.receive(completion: .failure(URLError(.cannotCreateFile)))
            }
        }
        
        func urlSession(
            _ session: URLSession,
            task: URLSessionTask,
            didCompleteWithError error: Error?
        ) {
            guard let error = error as? URLError else { return }
            subscriber?.receive(completion: .failure(error))
            session.invalidateAndCancel()
        }
        
        func urlSession(
            _ session: URLSession,
            downloadTask: URLSessionDownloadTask,
            didWriteData bytesWritten: Int64,
            totalBytesWritten: Int64,
            totalBytesExpectedToWrite: Int64
        ) {
            let bytesWritten = Int(totalBytesWritten)
            let bytesExpected = Int(totalBytesExpectedToWrite)
            let progress = bytesWritten.double / bytesExpected.double
            _ = subscriber?.receive(.downloading(progress: progress, bytesExpected: bytesExpected))
        }
    }
}


public extension URLSession {
    
    static func downloadTaskPublisher(for request: URLRequest) -> DownloadTaskPublisher {
        .init(request: request)
    }
    
    static func downloadTaskPublisher(for url: URL) -> DownloadTaskPublisher {
        .init(request: .init(url: url))
    }
}
