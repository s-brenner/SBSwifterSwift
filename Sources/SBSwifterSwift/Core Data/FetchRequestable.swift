#if canImport(CoreData)
import CoreData

public protocol FetchRequestable: AnyObject { }

extension FetchRequestable where Self: NSManagedObject {
    
    public static func createFetchRequest() -> NSFetchRequest<Self> {
        NSFetchRequest<Self>(entityName: String(describing: Self.self))
    }
}

extension NSManagedObject: FetchRequestable { }
#endif
