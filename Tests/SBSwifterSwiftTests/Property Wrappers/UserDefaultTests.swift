import XCTest
@testable import SBSwifterSwift

final class UserDefaultTests: XCTestCase {
    
    enum UserDefaultsManager {
        
        enum Settings {
            
            private static let prefix = "\(UserDefaultsManager.self).\(Self.self)"
            
            @UserDefault(key: "\(prefix).isEnabled", defaultValue: false)
            static var isEnabled: Bool
            
            @UserDefault(key: "\(prefix).username", defaultValue: "Steve")
            static var username: String
            
            @UserDefault(key: "\(prefix).soloNumber", defaultValue: 980)
            static var soloNumber: Int
            
            @UserDefault(key: "\(prefix).duration", defaultValue: DateComponents(hour: 4))
            static var duration: DateComponents
            
            @UserDefault(key: "\(prefix).speed", defaultValue: Speed(10, .knots))
            static var speed: Speed
            
            static func reset() {
                _isEnabled.reset()
                _username.reset()
                _duration.reset()
                _soloNumber.reset()
                _speed.reset()
            }
            
            static var soloNumberIsDefault: Bool { _soloNumber.isDefault }
        }
    }
    
    override class func setUp() {
        super.setUp()
        UserDefaultsManager.Settings.reset()
    }
    
    
    func testDefaultValue() {
        XCTAssertFalse(UserDefaultsManager.Settings.isEnabled)
        XCTAssertEqual(UserDefaultsManager.Settings.soloNumber, 980)
        XCTAssertEqual(UserDefaultsManager.Settings.duration, DateComponents(hour: 4))
    }
    
    func testIsDefault() {
        XCTAssertTrue(UserDefaultsManager.Settings.soloNumberIsDefault)
        UserDefaultsManager.Settings.soloNumber = 1000
        XCTAssertFalse(UserDefaultsManager.Settings.soloNumberIsDefault)
        UserDefaultsManager.Settings.reset()
        XCTAssertTrue(UserDefaultsManager.Settings.soloNumberIsDefault)
    }
    
    func testSetter() {
        XCTAssertEqual(UserDefaultsManager.Settings.username, "Steve")
        UserDefaultsManager.Settings.username = "Jim"
        XCTAssertEqual(UserDefaultsManager.Settings.username, "Jim")
        
        XCTAssertEqual(UserDefaultsManager.Settings.duration, DateComponents(hour: 4))
        UserDefaultsManager.Settings.duration = DateComponents(minute: 15)
        XCTAssertEqual(UserDefaultsManager.Settings.duration, DateComponents(minute: 15))
        
        XCTAssertEqual(UserDefaultsManager.Settings.speed, Speed(10, .knots))
        UserDefaultsManager.Settings.speed = Speed(25, .metersPerSecond)
        XCTAssertEqual(UserDefaultsManager.Settings.speed, Speed(25, .metersPerSecond).converted(to: .knots))
        
        UserDefaultsManager.Settings.reset()
    }
}
