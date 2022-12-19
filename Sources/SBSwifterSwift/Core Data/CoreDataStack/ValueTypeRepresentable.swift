import Foundation

public protocol ValueTypeRepresentable {
    
    associatedtype ValueType: Persistable
    
    func update(with valueType: ValueType)
    
    var valueType: ValueType { get }
}
