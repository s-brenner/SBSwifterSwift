import Foundation

extension URLRequest {
    
    public class Builder {
    
        private var method = HTTPMethod.get
        
        private var scheme = Scheme.https
        
        private var host = ""
        
        private var port: Int?
        
        private var path = ""
        
        private var queryItems = [URLQueryItem]()
        
        private var headers = [URLRequest.HTTPHeaderField]()
        
        public init() {}
    }
}


extension URLRequest.Builder {
    
    public enum Error: Swift.Error {
        case invalidURL
    }
    
    public enum HTTPMethod: String {
        case put = "PUT"
        case post = "POST"
        case get = "GET"
        case delete = "DELETE"
        case head = "HEAD"
    }
    
    public enum Scheme: String {
        case http
        case https
    }
    
    public func withMethod(_ method: HTTPMethod) -> Self {
        
        self.method = method
        return self
    }
    
    public func withScheme(_ scheme: Scheme) -> Self {
        
        self.scheme = scheme
        return self
    }
    
    public func withHost(_ host: String) -> Self {
        
        self.host = host
        return self
    }
    
    public func withPort(_ port: Int) -> Self {
        
        self.port = port
        return self
    }
    
    public func withPath(_ path: String) -> Self {
        
        self.path = path
        return self
    }
    
    public func withQueryItem(_ item: URLQueryItem) -> Self {
        
        queryItems.append(item)
        return self
    }
    
    public func withHeader(_ header: URLRequest.HTTPHeaderField) -> Self {
        
        headers.append(header)
        return self
    }
    
    public func build() -> URLRequest {
        
        switch compose() {
        case .failure(let error):
            fatalError(error.localizedDescription)
            
        case .success(let request):
            return request
        }
    }
    
    private func compose() -> Result<URLRequest, Error> {

        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else { return .failure(.invalidURL) }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers.forEach { request.setHTTPHeaderField(to: $0) }
        
        return .success(request)
    }
}


extension URLRequest {
    
    public enum MIMEType: CustomStringConvertible {
        
        case application(ApplicationSubtype)
        
        private var type: String {
            switch self {
            case .application: return "application"
            }
        }
        
        public var description: String {
            switch self {
            case .application(let subtype): return "\(type)/\(subtype.rawValue)"
            }
        }
        
        public enum ApplicationSubtype: String, CustomStringConvertible {
            case json
            case x_www_form_urlencoded = "x-www-form-urlencoded"
            
            public var description: String { rawValue }
        }
    }
    
    public enum HTTPHeaderField: CustomStringConvertible {
        case accept([MIMEType])
        case authorization(Authorization)
        
        public var field: String {
            switch self {
            case .accept: return "Accept"
            case .authorization: return "Authorization"
            }
        }
        
        public var value: String {
            switch self {
            case .accept(let mimes): return mimes.map { $0.description }.joined(separator: ",")
            case .authorization(let auth): return auth.value
            }
        }
        
        public var description: String { "\(field): \(value)" }
        
        public enum Authorization {
            case basic(username: String, password: String)
            case bearer(credential: String)
            
            var value: String {
                switch self {
                case let .basic(username, password):
                    return "Basic " + "\(username):\(password)".base64Encoded()!
                
                case let .bearer(credential):
                    return "Bearer \(credential)"
                }
            }
        }
    }
    
//    public func addValue(_ value: String, forHTTPHeaderField field: HTTPHeaderField) {
//
//        addValue(value, forHTTPHeaderField: field.rawValue)
//    }
//
    public mutating func setHTTPHeaderField(to field: HTTPHeaderField) {

        setValue(field.value, forHTTPHeaderField: field.field)
    }
    
    public func value(forHTTPHeaderField field: HTTPHeaderField) -> String? {
        
        value(forHTTPHeaderField: field.field)
    }
}


class XXX {
    
    func x() {
        
        let request = URLRequest.Builder()
            .withScheme(.http)
            .withHost("127.0.0.1")
            .withPort(8080)
            .withPath("/v1/users/login")
            .withMethod(.get)
            .withHeader(.accept([.application(.json)]))
            .withHeader(.authorization(.basic(username: "brenner.scott@gmail.com", password: "secret980")))
            .build()
    }
}
