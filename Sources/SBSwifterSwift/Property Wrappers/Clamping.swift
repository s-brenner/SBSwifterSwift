import Foundation

@propertyWrapper
public struct Clamping<Value: Comparable> {
    
    var value: Value
    
    let range: ClosedRange<Value>
    
    public var wrappedValue: Value {
        get { value }
        set { value = newValue.clamped(to: range) }
    }
    
    public init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        value = wrappedValue.clamped(to: range)
        self.range = range
    }
}
