//
//  Persistence.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import CoreData

final class BookmarkContainer {
    static let shared: BookmarkContainer = {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            return preview
        }
        
        let result = BookmarkContainer()
        
        return result
    }()

    private static let preview: BookmarkContainer = {
        let result = BookmarkContainer(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = BookmarkItemModel(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        print("\(type(of: self)) \(#function)")
        container = NSPersistentContainer(name: "CoreDataExample")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    deinit {
        print("\(type(of: self)) \(#function)")
    }
}