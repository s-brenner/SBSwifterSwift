//import CoreData
//
//extension NSPersistentStoreCoordinator {
//
//    @available(iOS 9.0, *)
//    public static func destroyStore(at storeURL: URL) {
//
//        //https://williamboles.me/progressive-core-data-migration/
//
//        do {
//            let persistentStoreCoordinator =
//                NSPersistentStoreCoordinator(managedObjectModel: NSManagedObjectModel())
//            try persistentStoreCoordinator.destroyPersistentStore(
//                at: storeURL,
//                ofType: NSSQLiteStoreType,
//                options: nil
//            )
//        } catch let error {
//            fatalError("Failed to destroy persistent store at \(storeURL), error: \(error)")
//        }
//    }
//
//    @available(iOS 9.0, *)
//    public static func replaceStore(at targetURL: URL, withStoreAt sourceURL: URL) {
//
//        //https://williamboles.me/progressive-core-data-migration/
//        
//        do {
//            let persistentStoreCoordinator =
//                NSPersistentStoreCoordinator(managedObjectModel: NSManagedObjectModel())
//            try persistentStoreCoordinator.replacePersistentStore(
//                at: targetURL,
//                destinationOptions: nil,
//                withPersistentStoreFrom: sourceURL,
//                sourceOptions: nil,
//                ofType: NSSQLiteStoreType
//            )
//        } catch let error {
//            fatalError("Failed to replace persistent store at \(targetURL) with \(sourceURL), error: \(error)")
//        }
//    }
//
//    public static func metadata(at storeURL: URL) -> [String : Any]?  {
//
//        //https://williamboles.me/progressive-core-data-migration/
//
//        try? NSPersistentStoreCoordinator.metadataForPersistentStore(
//            ofType: NSSQLiteStoreType,
//            at: storeURL,
//            options: nil
//        )
//    }
//
//    public func addPersistentStore(at storeURL: URL, options: [AnyHashable : Any]) -> NSPersistentStore {
//
//        //https://williamboles.me/progressive-core-data-migration/
//
//        do {
//            return try addPersistentStore(
//                ofType: NSSQLiteStoreType,
//                configurationName: nil,
//                at: storeURL,
//                options: options
//            )
//        } catch let error {
//            fatalError("Failed to add persistent store to coordinator, error: \(error)")
//        }
//    }
//}
