//#if canImport(Combine)
//import Combine
//
//public extension URLSession {
//
//    struct DownloadPublisher: Publisher {
//
//        public typealias Output = (progress: Progress?, data: Data?)
//
//        public typealias Failure = URLError
//
//        private let request: URLRequest
//
//        private let totalBytesExpected: Int64
//
//        init(request: URLRequest, totalBytesExpected: Int64 = NSURLSessionTransferSizeUnknown) {
//            self.request = request
//            self.totalBytesExpected = totalBytesExpected
//        }
//
//        public func receive<S>(subscriber: S)
//        where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
//            let subscription = Inner(
//                request: request,
//                subscriber: subscriber,
//                totalBytesExpected: totalBytesExpected
//            )
//            subscriber.receive(subscription: subscription)
//        }
//    }
//}
//
//
//private extension URLSession.DownloadPublisher {
//
//    class Inner<S: Subscriber>: NSObject, Subscription, URLSessionDownloadDelegate
//    where S.Input == (progress: Progress?, data: Data?), S.Failure == URLError {
//
//        private lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
//
//        private let request: URLRequest
//
//        private var subscriber: S?
//
//        private var progress: Progress?
//
//        private let totalBytesExpected: Int64
//
//        init(request: URLRequest, subscriber: S, totalBytesExpected: Int64) {
//
//            self.request = request
//            self.subscriber = subscriber
//            self.totalBytesExpected = totalBytesExpected
//            super.init()
//            let task = session.downloadTask(with: request)
//            task.resume()
//        }
//
//        func request(_ demand: Subscribers.Demand) { }
//
//        func cancel() {
//
//            subscriber = nil
//            progress = nil
//            session.invalidateAndCancel()
//        }
//
//        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//
//            guard let data = try? Data(contentsOf: location) else { return }
//            _ = subscriber?.receive((progress: nil, data: data))
//            subscriber?.receive(completion: .finished)
//            progress = nil
//            session.invalidateAndCancel()
//        }
//
//        func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//
//            guard let error = error as? URLError else { return }
//            subscriber?.receive(completion: .failure(error))
//            progress = nil
//            session.invalidateAndCancel()
//        }
//
//        func urlSession(
//            _ session: URLSession,
//            downloadTask: URLSessionDownloadTask,
//            didWriteData bytesWritten: Int64,
//            totalBytesWritten: Int64,
//            totalBytesExpectedToWrite: Int64) {
//
//            let total = totalBytesExpectedToWrite == NSURLSessionTransferSizeUnknown ? totalBytesExpected : totalBytesExpectedToWrite
//            if progress == nil {
//                progress = Progress(totalUnitCount: total == NSURLSessionTransferSizeUnknown ? 0 : total)
//                progress?.completedUnitCount = totalBytesWritten
//                _ = subscriber?.receive((progress: progress, data: nil))
//            }
//            else {
//                progress?.completedUnitCount = totalBytesWritten
//            }
//        }
//    }
//}
//
//
//public extension URLSession {
//
//    static func downloadPublisher(
//        for request: URLRequest,
//        totalBytesExpected total: Int64 = NSURLSessionTransferSizeUnknown) -> DownloadPublisher {
//
//        .init(request: request, totalBytesExpected: total)
//    }
//
//    static func downloadPublisher(
//        for url: URL,
//        totalBytesExpected total: Int64 = NSURLSessionTransferSizeUnknown) -> DownloadPublisher {
//
//        .init(request: .init(url: url), totalBytesExpected: total)
//    }
//}
//#endif
