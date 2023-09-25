

import CoreData

public class CoreDataStack {
   public static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        guard let modelURL = Bundle.module.url(forResource:"SocialNetwork", withExtension: "momd") else {
            return  NSPersistentContainer(name:"SocialNetwork")
        }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            return NSPersistentContainer(name:"SocialNetwork")
        }
        let container = NSPersistentContainer(name:"SocialNetwork",managedObjectModel:model)

        // Check if running in a test environment
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            // Use in-memory store for testing
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                debugPrint("Failed to load Core Data stack: \(error)")
            }
        }

        return container
    }()

    public var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = mainContext

        context.perform { [weak self] in
            do {
                try self?.mainContext.save()
            } catch {
                debugPrint("Failed to save main context: \(error)")
            }
        }
    }
}
