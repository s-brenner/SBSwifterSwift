#if canImport(UIKit)

import UIKit

public extension UIResponder {
    
    struct KeyboardNotification {
        
        public enum Event: CaseIterable {
            case willShow
            case didShow
            case willHide
            case didHide
            case willChangeFrame
            case didChangeFrame
            
            public var name: Notification.Name {
                switch self {
                case .willShow: return keyboardWillShowNotification
                case .didShow: return keyboardDidShowNotification
                case .willHide: return keyboardWillHideNotification
                case .didHide: return keyboardDidHideNotification
                case .willChangeFrame: return keyboardWillChangeFrameNotification
                case .didChangeFrame: return keyboardDidChangeFrameNotification
                }
            }
            
            public init?(_ name: Notification.Name) {
                
                switch name {
                case keyboardWillShowNotification: self = .willShow
                case keyboardDidShowNotification: self = .didShow
                case keyboardWillHideNotification: self = .willHide
                case keyboardDidHideNotification: self = .didHide
                case keyboardWillChangeFrameNotification: self = .willChangeFrame
                case keyboardDidChangeFrameNotification: self = .didChangeFrame
                default: return nil
                }
            }
        }
        
        public let event: Event
        
        public let name: Notification.Name
        
        /// Defines how the keyboard will be animated onto or off the screen.
        public let animationCurve: UIView.AnimationCurve
        
        /// Identifies the duration of the animation in seconds.
        public let animationDuration: TimeInterval
        
        /// Identifies whether the keyboard belongs to the current app
        public let isLocal: Bool
        
        /// Identifies the starting frame rectangle of the keyboard in screen coordinates.
        /// The frame rectangle reflects the current orientation of the device.
        public let frameBegin: CGRect
        
        /// Identifies the ending frame rectangle of the keyboard in screen coordinates.
        /// The frame rectangle reflects the current orientation of the device.
        public let frameEnd: CGRect
        
        public init?(_ notification: Notification) {
            
            guard let event = Event(notification.name),
                let userInfo = notification.userInfo else {
                    return nil
            }
            
            let animationCurve = userInfo[keyboardAnimationCurveUserInfoKey] as? UIView.AnimationCurve
            let animationDuration = userInfo[keyboardAnimationDurationUserInfoKey] as? TimeInterval
            let isLocal = userInfo[keyboardIsLocalUserInfoKey] as? Bool
            let frameBegin = userInfo[keyboardFrameBeginUserInfoKey] as? CGRect
            let frameEnd = userInfo[keyboardFrameEndUserInfoKey] as? CGRect
            
            self.event = event
            self.name = notification.name
            self.animationCurve = animationCurve ?? .easeInOut
            self.animationDuration = animationDuration ?? 0
            self.isLocal = isLocal ?? false
            self.frameBegin = frameBegin ?? .zero
            self.frameEnd = frameEnd ?? .zero
        }
    }
    
    @objc func handle(_ error: Error, from viewController: UIViewController, retryHandler: @escaping () -> Void) {
        
        // https://www.swiftbysundell.com/articles/propagating-user-facing-errors-in-swift/
        
        guard let nextResponder = next else {
            return assertionFailure("""
            Unhandled error \(error) from \(viewController)
            """)
        }
        
        nextResponder.handle(error, from: viewController, retryHandler: retryHandler)
    }
}
#endif
