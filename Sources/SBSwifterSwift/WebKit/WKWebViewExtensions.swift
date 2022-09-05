#if canImport(WebKit)
import WebKit

extension WKWebView {
    
    public var htmlString: String? {
        get async {
            try? await evaluateJavaScript("document.documentElement.outerHTML") as? String
        }
    }
    
    public func load(_ urlString: String) -> WKNavigation? {
        guard let url = URL(string: urlString) else { return nil }
        return load(url)
    }
    
    public func load(_ url: URL) -> WKNavigation? {
        load(URLRequest(url: url))
    }
    
    public func printHTML() async {
        guard let html = await htmlString, let title else { return }
        print("******************************************************************************************************")
        print("***** Begin HTML: \(title)")
        print("******************************************************************************************************")
        print(html)
        print("******************************************************************************************************")
        print("***** End HTML: \(title)")
        print("******************************************************************************************************")
    }
}
#endif
