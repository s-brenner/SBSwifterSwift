import Foundation

@propertyWrapper
public struct Clamping<Value: Comparable> {
    
    // MARK: - Properties
    
    var value: Value
    
    let range: ClosedRange<Value>
    
    public var wrappedValue: Value {
        get { value }
        set { value = newValue.clamped(to: range) }
    }
    
    
    // MARK: - Initializers
    
    public init(initialValue value: Value, _ range: ClosedRange<Value>) {
        self.value = value.clamped(to: range)
        self.range = range
    }
}
