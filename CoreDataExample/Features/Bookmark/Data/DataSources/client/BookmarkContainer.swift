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
        
        let list1 = BookmarkListModel(context: viewContext)
        list1.id = "1"
        list1.timestamp = Date()
        list1.title = "List 1"

        let regulation1 = BookmarkItemModel(context: viewContext)
        regulation1.id = "1"
        regulation1.timestamp = Date()
        regulation1.type = "regulation"
        regulation1.title = "Undang-Undang Nomor 1 Tahun 2001 Tentang Pengesahan Persetujuan Antara Pemerintah Republik Indonesia Dan Pemerintah Hongkong Untuk Penyerahan Pelanggar Hukum Yang Melarikan Diri (Agreement Between The Government Of The Republic Of Indonesia And The Government Of Hongkong For The Surrender Of Fug"
        regulation1.url = "uu-18-2009"
        regulation1.list = list1
        
        let definition1 = BookmarkItemModel(context: viewContext)
        definition1.id = "2"
        definition1.timestamp = Date() + 1
        definition1.type = "definition"
        definition1.title = "Dewan Nasional"
        definition1.document_id = "ad383590-0b76-11ea-9ec4-93cd37256352"
        definition1.definition = "Dewan Nasional"
        definition1.list = list1
        
        let list2 = BookmarkListModel(context: viewContext)
        list2.id = "2"
        list2.timestamp = Date() + 1
        list2.title = "List 2"
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            return result
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
        container = NSPersistentCloudKitContainer(name: "CoreDataExample")
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
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
    }
}
