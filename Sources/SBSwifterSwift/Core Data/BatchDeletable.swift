#if canImport(CoreData)
import CoreData

public protocol BatchDeletable: AnyObject { }

extension BatchDeletable where Self: NSManagedObject {
    
    public static func createBatchDeleteRequest(
        predicate: NSPredicate? = nil,
        resultType: NSBatchDeleteRequestResultType = .resultTypeObjectIDs
    ) -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Self.self))
        fetchRequest.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = resultType
        return deleteRequest
    }
}

extension NSManagedObject: BatchDeletable { }
#endif
