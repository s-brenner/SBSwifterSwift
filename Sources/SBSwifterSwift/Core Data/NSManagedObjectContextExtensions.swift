#if canImport(CoreData) && canImport(SBLogging)
import CoreData
import SBLogging

extension NSManagedObjectContext {
    
    public struct ChangeCount {
        
        public let inserted: Int
        
        public let updated: Int
        
        public let deleted: Int
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
    
    /// Attempts to commit unsaved changes to registered objects to the context’s parent store.
    /// - Throws: errors encountered as a result of `save()`.
    /// - Returns: `true` if a save occurred.
    @discardableResult
    public func saveIfNeeded() throws -> Bool {
        guard hasChanges else { return false }
        try save()
        return true
    }
    
    @available(iOS 14, tvOS 14, macOS 11, watchOS 7, *)
    public func changesPublisher<Object>(for fetchRequest: NSFetchRequest<Object>) -> ChangesPublisher<Object> {
        ChangesPublisher(fetchRequest: fetchRequest, context: self)
    }
    
    @available(iOS 14, tvOS 14, macOS 11, watchOS 7, *)
    public struct ChangesPublisher<Object: NSManagedObject>: Publisher {
        
        public typealias Output = [Object]
        
        public typealias Failure = Error
        
        private let fetchRequest: NSFetchRequest<Object>
        
        private let context: NSManagedObjectContext
        
        public init(fetchRequest: NSFetchRequest<Object>, context: NSManagedObjectContext) {
            self.fetchRequest = fetchRequest
            self.context = context
        }
        
        public func receive<S: Subscriber>(subscriber: S)
        where Output == S.Input, Failure == S.Failure {
            
            let inner = Inner(
                downstream: subscriber,
                fetchRequest: fetchRequest,
                context: context
            )
            subscriber.receive(subscription: inner)
        }
    }
}

@available(iOS 14, tvOS 14, macOS 11, watchOS 7, *)
extension NSManagedObjectContext.ChangesPublisher {
    
    @available(iOS 14, tvOS 14, macOS 11, watchOS 7, *)
    class Inner<Downstream: Subscriber>: NSObject, Subscription, NSFetchedResultsControllerDelegate
    where Downstream.Input == [Object], Downstream.Failure == Error {
        
        private let downstream: Downstream
        
        private var fetchedResultsController: NSFetchedResultsController<Object>?
        
        private var demand: Subscribers.Demand = .none
        
        private lazy var logger = Logger(category: "NSManagedObjectContext.ChangesPublisher")
        
        init(downstream: Downstream, fetchRequest: NSFetchRequest<Object>, context: NSManagedObjectContext) {
            self.downstream = downstream
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            super.init()
            fetchedResultsController!.delegate = self
            do {
                try fetchedResultsController!.performFetch()
                log("NSFetchedResultsController performed fetch")
            } catch {
                downstream.receive(completion: .failure(error))
                log(error.localizedDescription, isError: true)
            }
        }
        
        private func log(_ message: String, isError: Bool = false) {
            isError ? logger.error("\(message)") : logger.info("\(message)")
        }
        
        func request(_ demand: Subscribers.Demand) {
            self.demand += demand
            fulfillDemand()
        }
        
        func cancel() {
            log("Cancel")
            fetchedResultsController?.delegate = nil
            fetchedResultsController = nil
        }
        
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            log("NSFetchedResultsController did change content")
            fulfillDemand()
        }
        
        private func fulfillDemand() {
            guard demand > 0 else { return }
            let objects = fetchedResultsController?.fetchedObjects ?? []
            let newDemand = downstream.receive(objects)
            let item = String(describing: Downstream.Input.Element.self)
            log("\(objects.count) \(item)\(objects.count == 1 ? "" : "s") sent downstream")
            demand += newDemand
            demand -= 1
        }
    }
}
#endif
