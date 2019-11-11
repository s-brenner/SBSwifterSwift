import CoreData

extension NSManagedObjectContext {
    
    public struct ChangeCount {
        let inserted: Int
        let updated: Int
        let deleted: Int
    }
    
    @discardableResult
    public func saveOrRollback() -> Result<ChangeCount, Error> {
        do {
            let inserted = insertedObjects.count
            let updated = updatedObjects.count
            let deleted = deletedObjects.count
            try save()
            return .success(.init(inserted: inserted, updated: updated, deleted: deleted))
        } catch {
            rollback()
            return .failure(error)
        }
    }
}
