import XCTest
@testable import SBSwifterSwift

final class URLSessionExtensionsTests: XCTestCase {
    
    private struct Post: Codable {
        
        let id: Int
        let title: String
        let body: String
        let userId: Int
    }
    
    func testRequest() {
        
        // https://jsonplaceholder.typicode.com
        
        let request = URLRequest.Builder()
            .withScheme(.https)
            .withHost("jsonplaceholder.typicode.com")
            .withPath("/posts/1")
            .withHeader(.accept([.application(.json)]))
            .build()
        
        let expectation = self.expectation(description: "1")
        
        URLSession.shared.dataTask(with: request, decodedAs: Post.self) { result, _  in
            
            switch result {
            case let .success(post):
                XCTAssertEqual(post.id, 1)
                XCTAssertEqual(post.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
                expectation.fulfill()
                
            case let .failure(error):
                print(error)
            }
        }.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
