import CoreData
import Foundation

public final class PersistenceController: @unchecked Sendable {
    public static let shared = PersistenceController()

    public static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        for _ in 0..<10 {
            let item = NSEntityDescription.insertNewObject(
                forEntityName: "Item",
                into: viewContext
            )
            item.setValue(Date(), forKey: "timestamp")
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

        return result
    }()

    public let container: NSPersistentContainer

    public init(inMemory: Bool = false) {
        let model = Self.makeManagedObjectModel()
        container = NSPersistentContainer(name: "Marktek", managedObjectModel: model)

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    private static func makeManagedObjectModel() -> NSManagedObjectModel {
        let modelURL = Bundle.module.url(forResource: "Marktek", withExtension: "momd")
            ?? Bundle.module.url(forResource: "Marktek", withExtension: "mom")
            ?? Bundle.module.url(forResource: "Marktek", withExtension: "xcdatamodeld")

        guard let modelURL,
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to load Marktek Core Data model from Persistence package.")
        }

        return model
    }
}

extension PersistenceController: CoreDataContextProvider {
    public var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    public func newBackgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }
}
