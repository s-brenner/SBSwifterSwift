import XCTest
@testable import SBSwifterSwift

final class ClampingTests: XCTestCase {
    
    // MARK: - Types
    
    private struct Solution {
        
        @Clamping(0...14) var ph = 7.0
    }
    
    
    // MARK: - Tests
    
    func test() {
        
        let carbonicAcid = Solution(ph: 4.68)
        let superDuperAcid = Solution(ph: -1)
        
        XCTAssertEqual(carbonicAcid.ph, 4.68)
        XCTAssertEqual(superDuperAcid.ph, 0)
    }
}
