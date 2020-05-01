import Foundation

extension URLSession {
    
    public func dataTask(
        with url: URL,
        completionHandler: @escaping (_ result: Result<Data, Error>, _ response: URLResponse?) -> Void
    ) -> URLSessionDataTask {
        
        dataTask(with: url) { data, response, error in
            
            if let error = error {
                completionHandler(.failure(error), response)
            }
            else {
                completionHandler(.success(data ?? Data()), response)
            }
        }
    }
    
    public func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (_ result: Result<Data, Error>, _ response: URLResponse?) -> Void
    ) -> URLSessionDataTask {
        
        dataTask(with: request) { data, response, error in
            
            if let error = error {
                completionHandler(.failure(error), response)
            }
            else {
                completionHandler(.success(data ?? Data()), response)
            }
        }
    }
    
    
    /// Creates a task that retrieves the contents of a URL based on the specified URL request object, decodes the JSON payload, and calls a handler upon completion.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameter request: A URL request object that provides the URL, cache policy, request type, body data or body stream, and so on.
    /// - Parameter type: The type of object into which the decoder will decode the server data.
    /// - Parameter decoder: The decoder to use.
    /// - Parameter completionHandler: The completion handler to call when the load request is complete. This handler is executed on the delegate queue.
    /// - Parameter result: The decoded object returned by the server or an error object that indicates why the request failed.
    /// - Parameter response: An object that provides response metadata, such as HTTP headers and status code.
    /// - Returns: The new session data task.
    public func dataTask<T: Decodable>(
        with request: URLRequest,
        decodedAs type: T.Type,
        usingDecoder decoder: JSONDecoder = .init(),
        completionHandler: @escaping (_ result: Result<T, Error>, _ response: URLResponse?) -> Void
    ) -> URLSessionDataTask {
        
        dataTask(with: request) { result, response in
            
            switch result {
            case .success(let data):
                do {
                    let decoded = try decoder.decode(T.self, from: data)
                    completionHandler(.success(decoded), response)
                }
                catch {
                    print(data.prettyPrintedJSONString)
                    completionHandler(.failure(error), response)
                }
                
            case .failure(let error):
                completionHandler(.failure(error), response)
            }
        }
    }
}
