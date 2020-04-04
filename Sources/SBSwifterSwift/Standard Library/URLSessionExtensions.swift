import Foundation

extension URLSession {
    
    public func dataTask(with url: URL, handler: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        
        dataTask(with: url) { data, _, error in
            
            if let error = error {
                handler(.failure(error))
            }
            else {
                handler(.success(data ?? Data()))
            }
        }
    }
}
