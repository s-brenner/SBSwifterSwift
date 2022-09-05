import XCTest
@testable import SBSwifterSwift

final class URLSessionExtensionsTests: XCTestCase {
    
    @available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
    func testDownloadStatus() async {
        let url = URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/iss067e005682.jpg")!
        do {
            var expectedContentLength = 0
            var downloadProgress = -0.01
            for try await status in URLSession.shared.downloadStatus(from: url) {
                switch status {
                case .response(let response):
                    expectedContentLength = Int(response.expectedContentLength)
                case .downloading(let progress):
                    XCTAssertEqual(progress, downloadProgress + 0.01, accuracy: 0.0001)
                    downloadProgress = progress
                case .finished(let data):
                    XCTAssertEqual(data.count, expectedContentLength)
                }
            }
        }
        catch {
            print(error)
            XCTFail("\(error.localizedDescription)")
        }
    }
}
