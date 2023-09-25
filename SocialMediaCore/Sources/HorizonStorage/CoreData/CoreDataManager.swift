//
//  File.swift
//
//
//  Created by MahmoudFares on 23/09/2023.
//

import CoreData

public class CoreDataManager {
    public static let shared = CoreDataManager()

    private let coreDataStack = CoreDataStack.shared

   public  func fetch<T: NSManagedObject>(_ entityClass: T.Type) -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityClass))
        do {
            return try coreDataStack.mainContext.fetch(fetchRequest)
        } catch {
            debugPrint("Failed to fetch data: \(error)")
            return []
        }
    }

     func save() {
        coreDataStack.saveContext()
    }

    public func delete<T: NSManagedObject>(_ object: T) {
        coreDataStack.mainContext.delete(object)
        save()
    }
    
    public func deleteAllPosts<T: NSManagedObject>(_ entityClass: T.Type) {
        let context = coreDataStack.mainContext
        
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: entityClass))
        
        do {
            let posts = try context.fetch(fetchRequest)
            
            for post in posts {
                context.delete(post)
            }
            
            try context.save() // Save the context to persist the changes
        } catch {
            debugPrint("Error deleting all posts: \(error)")
        }
    }

    public func saveArrayToCoreData<T: NSManagedObject>(_ array: [T]) {
        let context = coreDataStack.mainContext
        
        for item in array {
            context.insert(item)
        }
        
        do {
            try context.save() // Save the context to persist the changes
        } catch {
            debugPrint("Error saving array to Core Data: \(error)")
        }
    }


    // Add other methods for updating and performing specific operations as needed
}
