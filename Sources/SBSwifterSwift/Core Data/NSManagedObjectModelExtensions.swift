import CoreData

extension NSManagedObjectModel {

    public static func managedObjectModel(
        forResource resource: String,
        subdirectory: String? = nil) -> NSManagedObjectModel {
        
        //https://williamboles.me/progressive-core-data-migration/
        
        let mainBundle = Bundle.main
        let omoURL = mainBundle.url(forResource: resource, withExtension: "omo", subdirectory: subdirectory)
        let momURL = mainBundle.url(forResource: resource, withExtension: "mom", subdirectory: subdirectory)

        guard let url = omoURL ?? momURL else {
            fatalError("Unable to find model in bundle")
        }

        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Unable to load model in bundle")
        }

        return model
    }
    
    public static func compatibleModelForStoreMetadata(
        _ metadata: [String : Any]) -> NSManagedObjectModel? {
        
        //https://williamboles.me/progressive-core-data-migration/
        
        NSManagedObjectModel.mergedModel(from: [.main], forStoreMetadata: metadata)
    }
}
