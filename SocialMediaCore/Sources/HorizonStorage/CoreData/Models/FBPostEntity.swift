import CoreData

@objc(FBPostEntity) // Match this to the name of your Core Data entity
public class FBPostEntity: NSManagedObject {
    @NSManaged public var id: Int
    @NSManaged public var name: String
    @NSManaged public var body: String
    @NSManaged public var title: String
}
