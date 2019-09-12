import XCTest
@testable import SBSwifterSwift

final class SequenceExtensionsTests: XCTestCase {
    
    private struct Day: Hashable {
        
        let espressoShots: Int
        
        static let yesterday = Day(espressoShots: 4)
        static let today = Day(espressoShots: 2)
    }
    
    private let days: Set<Day> = [.yesterday, .today]
    
    func testSum() {
        XCTAssertEqual(days.sum(for: \.espressoShots),
                       Day.yesterday.espressoShots + Day.today.espressoShots)
    }
    
    func testMap() {
        let shots = days.map(\.espressoShots)
        
        XCTAssertEqual(shots.count, days.count)
        XCTAssertTrue(shots.contains(Day.yesterday.espressoShots))
        XCTAssertTrue(shots.contains(Day.today.espressoShots))
    }
    
    func testSorted() {
        XCTAssertEqual(days.sorted(by: \.espressoShots).first?.espressoShots,
                       Day.today.espressoShots)
        XCTAssertEqual(days.sorted(by: \.espressoShots, ascending: false).first?.espressoShots,
                       Day.yesterday.espressoShots)
    }
}
