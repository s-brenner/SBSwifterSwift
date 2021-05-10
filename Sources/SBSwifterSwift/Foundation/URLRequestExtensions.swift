#if os(iOS) || os(macOS) || os(watchOS)
public extension URLRequest {
    
    @available(*, deprecated, message: "Use SBNetworking instead")
    class Builder {
    
        private var method = HTTPMethod.get
        
        private var scheme = Scheme.https
        
        private var host = ""
        
        private var port: Int?
        
        private var path = ""
        
        private var queryItems = [URLQueryItem]()
        
        private var headers = [URLRequest.HTTPHeaderField]()
        
        private var body: Data?
        
        public init() {}
    }
}


public extension URLRequest.Builder {
    
    enum Error: Swift.Error {
        case invalidURL
    }
    
    enum HTTPMethod: String {
        case put = "PUT"
        case post = "POST"
        case get = "GET"
        case delete = "DELETE"
        case head = "HEAD"
    }
    
    enum Scheme: String {
        case http
        case https
    }
    
    func withMethod(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    func withScheme(_ scheme: Scheme) -> Self {
        self.scheme = scheme
        return self
    }
    
    func withHost(_ host: String) -> Self {
        self.host = host
        return self
    }
    
    func withPort(_ port: Int) -> Self {
        self.port = port
        return self
    }
    
    func withPath(_ path: String) -> Self {
        self.path = path
        return self
    }
    
    func withQueryItem(_ item: URLQueryItem) -> Self {
        queryItems.append(item)
        return self
    }
    
    func withHeader(_ header: URLRequest.HTTPHeaderField) -> Self {
        headers.append(header)
        return self
    }
    
    func withBody(_ body: Data?, encoding: URLRequest.BodyEncoding = .none) -> Self {
        if let header = encoding.header {
            headers.append(header)
        }
        self.body = body
        return self
    }
    
    func withJSONBody<Value: Encodable>(
        _ value: Value,
        encodedWith encoder: JSONEncoder = .init()
    ) -> Self {
        self.withBody(try? encoder.encode(value), encoding: .json)
    }
    
    func build() -> URLRequest {
        switch compose() {
        case .failure(let error):
            fatalError(error.localizedDescription)
        case .success(let request):
            return request
        }
    }
}

private extension URLRequest.Builder {
    
    func compose() -> Result<URLRequest, Error> {
        let components = configure(URLComponents()) {
            $0.scheme = scheme.rawValue
            $0.host = host
            $0.port = port
            $0.path = path
            $0.queryItems = queryItems.isEmpty ? nil : queryItems
        }
        guard let url = components.url else { return .failure(.invalidURL) }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers.forEach { request.setHTTPHeaderField(to: $0) }
        request.httpBody = body
        return .success(request)
    }
}


public extension URLRequest {
    
    enum BodyEncoding {
        case none
        case formData
        case json
        case x_www_form_urlencoded
        
        var header: HTTPHeaderField? {
            switch self {
            case .none:
                return nil
                
            case .formData:
                return .contentType(.multipart(.form_data))
                
            case .json:
                return .contentType(.application(.json))
                
            case .x_www_form_urlencoded:
                return .contentType(.application(.x_www_form_urlencoded))
            }
        }
    }
    
    enum MIMEType: CustomStringConvertible {
        case application(ApplicationSubtype)
        case image(ImageSubtype)
        case multipart(MultipartSubtype)
        case text(TextSubtype)
        
        private var type: String {
            switch self {
            case .application:
                return "application"
                
            case .image:
                return "image"
                
            case .multipart:
                return "multipart"
                
            case .text:
                return "text"
            }
        }
        
        public var description: String {
            var subtype: String {
                switch self {
                case .application(let sub):
                    return sub.description
                    
                case .image(let sub):
                    return sub.description
                    
                case .multipart(let sub):
                    return sub.description
                    
                case .text(let sub):
                    return sub.description
                }
            }
            return "\(type)/\(subtype)"
        }
        
        public enum ApplicationSubtype: String, MIMESubtype {
            case atom_xml = "atom+xml"
            case ecmascript
            case json
            case javascript
            case octet_stream = "octet-stream"
            case ogg
            case pdf
            case postscript
            case rdf_xml = "rdf+xml"
            case rss_xml = "rss+xml"
            case soap_xml = "soap+xml"
            case font_woff = "font-woff"
            case x_yaml = "x-yaml"
            case xhtml_xml = "xhtml+xml"
            case xml
            case xml_dtd = "xml-dtd"
            case xop_xml = "xop+xml"
            case zip
            case gzip
            case graphql
            case x_www_form_urlencoded = "x-www-form-urlencoded"
        }
        
        public enum ImageSubtype: String, MIMESubtype {
            case gif, jpeg, pjpeg, png
            case svg_xml = "svg+xml"
            case tiff
        }
        
        public enum MultipartSubtype: String, MIMESubtype {
            case mixed, alternative, related
            case form_data = "form-data"
            case signed, encrypted
        }
        
        public enum TextSubtype: String, MIMESubtype {
            case cmd, css, csv, html, plain, vcard, xml
        }
    }
    
    enum HTTPHeaderField: CustomStringConvertible {
        case accept([MIMEType])
        case authorization(Authorization)
        case contentType(MIMEType)
        
        public var key: Key {
            switch self {
            case .accept:
                return .accept
                
            case .authorization:
                return .authorization
                
            case .contentType:
                return .contentType
            }
        }
        
        public var value: String {
            switch self {
            case .accept(let mimes):
                return mimes.map { $0.description }.joined(separator: ",")
                
            case .authorization(let auth):
                return auth.value
                
            case .contentType(let mime):
                return mime.description
            }
        }
        
        public var description: String { "\(key.description): \(value)" }
        
        public enum Key: String, CustomStringConvertible {
            case accept = "Accept"
            case authorization = "Authorization"
            case contentType = "Content-Type"
            
            public var description: String { rawValue }
        }
        
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
    
    mutating func setHTTPHeaderField(to field: HTTPHeaderField) {
        setValue(field.value, forHTTPHeaderField: field.key.description)
    }
    
    func value(forHTTPHeaderField key: HTTPHeaderField.Key) -> String? {
        value(forHTTPHeaderField: key.description)
    }
}


public protocol MIMESubtype: RawRepresentable, CustomStringConvertible {}

public extension MIMESubtype where Self.RawValue == String {
    
    var description: String { rawValue }
}
#endif
