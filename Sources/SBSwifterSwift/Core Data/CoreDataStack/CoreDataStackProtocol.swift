#if canImport(Combine) && canImport(CoreData)
import Combine
import CoreData

@available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
public protocol CoreDataStackProtocol: AnyObject {
    
    var persistentContainer: NSPersistentCloudKitContainer { get }
}


// MARK: - Contexts

@available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
extension CoreDataStackProtocol {
    
    /// The main queue’s managed object context.
    ///
    /// This property contains a reference to the `NSManagedObjectContext` that is created and owned by the Core Data Stack
    /// which is associated with the main queue of the application. This context is created automatically as part of the
    /// initialization of the Core Data Stack.
    public var viewContext: NSManagedObjectContext { persistentContainer.viewContext }
    
    /// Returns a new managed object context that executes on a private queue.
    ///
    /// Invoking this method causes the Core Data Stack to create and return a new `NSManagedObjectContext`
    /// with the concurrencyType set to `NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType`.
    /// This new context will be associated with the `NSPersistentStoreCoordinator` directly and is set to
    /// consume `NSManagedObjectContextDidSave` broadcasts automatically.
    public func newBackgroundContext() -> NSManagedObjectContext { persistentContainer.newBackgroundContext() }
}


// MARK: - Create

@available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
extension CoreDataStackProtocol {
    
    private func createDatabaseObject<T: Persistable>(for persistable: T, on context: NSManagedObjectContext) -> T.DatabaseObject
    where T.DatabaseObject: NSManagedObject {
        T.DatabaseObject(context: context)
    }
}


// MARK: - Retrieve

@available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
extension CoreDataStackProtocol {
    
    /// Retrieve persistable values of a specified type from the database.
    /// - Parameter type: The type of persistable value to retrieve.
    /// - Parameter predicate: A predicate that determines which peristable values to retrieve.
    /// Defaults to `nil` which results in all persistable values of the given type being returned.
    /// - Parameter sortDescriptors: An array of sort descriptors that determine how the returned array is sorted.
    /// Defaults to `nil` which results in no sorting of the returned array.
    /// - Parameter fetchLimit :The limit of persistable values to fetch from the database.
    /// Defaults to`nil` which results in no application of a limit.
    /// - Returns: An array of persistable values retrieved from the database.
    public func retrievePersistableValues<T: Persistable>(
        ofType type: T.Type,
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil,
        fetchLimit: Int? = nil
    ) async -> [T.DatabaseObject.ValueType]
    where T.DatabaseObject: NSManagedObject {
        let context = newBackgroundContext()
        return await context.perform {
            let request = T.DatabaseObject.createFetchRequest()
            request.predicate = predicate
            request.sortDescriptors = sortDescriptors
            if let fetchLimit {
                request.fetchLimit = fetchLimit
            }
            do {
                return try context.fetch(request).map(\.valueType)
            }
            catch {
                return []
            }
        }
    }
    
    /// Retrieve persistable values of a specified type from the database.
    /// - Parameter type: The type of persistable value to retrieve.
    /// - Parameter identifiers: The identifiers of the persistable items to retrieve.
    /// - Parameter sortDescriptors: An array of sort descriptors that determine how the returned array is sorted.
    /// Defaults to `nil` which results in no sorting of the returned array.
    /// - Returns: An array of persistable values retrieved from the database.
    public func retrievePersistableValues<T: Persistable>(
        ofType type: T.Type,
        withIdentifiers identifiers: [UUID],
        sortDescriptors: [NSSortDescriptor]? = nil
    ) async -> [T.DatabaseObject.ValueType]
    where T.DatabaseObject: NSManagedObject {
        let context = newBackgroundContext()
        let request = T.DatabaseObject.createFetchRequest()
        request.predicate = Self.persistableValueID(in: identifiers)
        request.sortDescriptors = sortDescriptors
        do {
            return try await context.perform {
                try context.fetch(request).map(\.valueType)
            }
        }
        catch {
            return []
        }
    }
    
    private func retrieveDatabaseObject<T: Persistable>(
        for persistable: T,
        on context: NSManagedObjectContext? = nil
    ) async -> T.DatabaseObject?
    where T.DatabaseObject: NSManagedObject {
        let context = context ?? newBackgroundContext()
        let request = T.DatabaseObject.createFetchRequest()
        request.predicate = Self.persistableValueID(is: persistable.id)
        request.fetchLimit = 1
        do {
            return try await context.perform {
                try context.fetch(request).first
            }
        }
        catch {
            return nil
        }
    }
}


// MARK: - Update

@available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
extension CoreDataStackProtocol {
    
    /// Updates or creates database objects for the provided persistable values on a background context and
    /// then saves the changes to the background context.
    /// - Throws: Core Data errors associated with saving the managed object context.
    public func updateDatabase<T: Persistable>(with persistables: [T]) async throws
    where T.DatabaseObject: NSManagedObject, T == T.DatabaseObject.ValueType {
        let context = newBackgroundContext()
        for persistable in persistables {
            await updateDatabaseObject(for: persistable, on: context)
        }
        guard context.hasChanges else { return }
        try context.save()
    }
    
    /// First, retrieves an existing database object corresponding to the provided persistable value or creates a new one.
    /// Then, updates the database object with the provided persistable value.
    /// - Important: The managed object context changes are not saved as a result of this operation.
    /// - Parameter persistable: The persistable value to update in the database.
    /// - Parameter context: The managed object context on which to assign the database object.
    /// As the changes to the context are not saved, you must maintain a reference to it until its changes are saved or abandoned.
    private func updateDatabaseObject<T: Persistable>(for persistable: T, on context: NSManagedObjectContext) async
    where T.DatabaseObject: NSManagedObject, T == T.DatabaseObject.ValueType {
        let object = await retrieveDatabaseObject(for: persistable, on: context) ?? createDatabaseObject(for: persistable, on: context)
        object.update(with: persistable)
    }
}


// MARK: - Delete

@available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
extension CoreDataStackProtocol {
    
    /// Deletes the given persistable value from the database provided
    /// that the database contains a record of the value.
    ///
    /// The delete operation occurs on a private queue.
    /// - Parameter persistable: The value to delete from the database.
    /// - Throws: Core Data errors resulting from an attempted database save operation.
    public func delete<T: Persistable>(_ persistable: T) async throws
    where T.DatabaseObject: NSManagedObject {
        let context = newBackgroundContext()
        guard let object = await retrieveDatabaseObject(for: persistable, on: context) else { return }
        try await context.perform {
            context.delete(object)
            guard context.hasChanges else { return }
            try context.save()
        }
    }
    
    /// Batch deletes all of the provided persistable values.
    /// - Important: In the name of efficiency, this method does not load the database objects
    /// into memory prior to deleting them.
    /// - Parameter persistables: The persistable items to delete from the database.
    /// - Throws: Core Data errors resulting from an attempted database save operation.
    public func delete<T: Persistable>(_ persistables: [T]) async throws
    where T.DatabaseObject: NSManagedObject {
        let predicate = Self.persistableValueID(in: persistables.map(\.id))
        try await deleteAll(ofType: T.self, predicate: predicate)
    }
    
    /// Batch deletes all objects of a given type that match a predicate.
    /// - Important: In the name of efficiency, this method does not load the database objects
    /// into memory prior to deleting them.
    /// - Parameter type: The type of persistable items to delete.
    /// - Parameter predicate: Determines which persistable items to delete.
    /// Defaults to `nil` which results in all items of the given type being deleted.
    /// - Throws: Core Data errors resulting from an attempted database save operation.
    public func deleteAll<T: Persistable>(ofType type: T.Type, predicate: NSPredicate? = nil) async throws
    where T.DatabaseObject: NSManagedObject {
        let request = T.DatabaseObject.createBatchDeleteRequest(predicate: predicate)
        let context = newBackgroundContext()
        try await context.perform { [unowned self] in
            try context.execute(request, mergeChangesInto: [viewContext])
        }
    }
}


// MARK: - Publishers

@available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
extension CoreDataStackProtocol {
    
    public typealias ChangeType = NSManagedObjectContext.ChangeType
    
    public typealias Change<T: Persistable> = NSManagedObjectContext.Change<T>
    
    /// Publishes the changes that occurred when objects merged into the view context.
    /// - Parameter type: The type of objects that must merge in order to trigger the publisher.
    /// - Parameter changeTypes: The change types to listen for. Defaults to `allCases`.
    /// - Returns: A publisher of the changes that occurred when objects merged into the view context.
    public func mergePublisher<T: Persistable>(
        for type: T.Type,
        changeTypes: [ChangeType] = ChangeType.allCases
    ) -> AnyPublisher<[Change<T>], Never>
    where T.DatabaseObject: NSManagedObject {
        viewContext
            .publisher(for: T.DatabaseObject.self, changeTypes: changeTypes, action: .didMerge)
            .compactMapEach { change in
                switch change.changeType {
                case .deleted:
                    return Change(objects: [], changeType: .deleted)
                default:
                    let objects = change.objects.compactMap { $0.valueType as? T }
                    return Change(objects: objects, changeType: change.changeType)
                }
            }
    }
}


// MARK: - Predicates

@available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
extension CoreDataStackProtocol {
    
    private static func persistableValueID(is identifier: UUID) -> NSPredicate {
        NSPredicate(format: "%K = %@", "uuid", identifier as CVarArg)
    }
    
    private static func persistableValueID(in identifiers: [UUID]) -> NSPredicate {
        NSPredicate(format: "%K IN %@", "uuid", identifiers.map { $0 as CVarArg })
    }
}
#endif
