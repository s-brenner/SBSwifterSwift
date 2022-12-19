import Foundation

public protocol Persistable: Identifiable, Equatable {
    
    associatedtype DatabaseObject: ValueTypeRepresentable
    
    var id: UUID { get }
}
