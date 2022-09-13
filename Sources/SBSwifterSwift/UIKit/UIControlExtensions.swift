#if canImport(UIKit) && os(iOS)
import UIKit

extension UIControl {
    
    public func publisher(for event: Event) -> EventPublisher {
        EventPublisher(control: self, event: event)
    }
    
    public struct EventPublisher: Publisher {
        
        public typealias Output = Void
        
        public typealias Failure = Never
        
        fileprivate var control: UIControl
        
        fileprivate var event: Event
        
        public func receive<S: Subscriber>(subscriber: S)
        where S.Input == Output, S.Failure == Failure {
            
            let subscription = EventSubscription<S>()
            subscription.target = subscriber
            
            subscriber.receive(subscription: subscription)
            
            control.addTarget(
                subscription,
                action: #selector(subscription.trigger),
                for: event
            )
        }
    }
}

fileprivate extension UIControl {
    
    class EventSubscription<Target: Subscriber>: Subscription
    where Target.Input == Void {
            
        var target: Target?
        
        func request(_ demand: Subscribers.Demand) { }
        
        func cancel() {
            
            target = nil
        }
        
        @objc func trigger() {
            
            _ = target?.receive(())
        }
    }
}
#endif
