//
//  BookmarkDataSource.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation
import CoreData

protocol BookmarkDataSource {
    func get() -> [BookmarkItemModel]?
    func add() -> Bool
    func delete(offsets: IndexSet) -> Bool
}

final class BookmarkLocalDataSource: BookmarkDataSource {
    private var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        print("\(type(of: self)) \(#function)")
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func get() -> [BookmarkItemModel]? {
        print("\(BookmarkLocalDataSource.self) \(#function)")
        
        let fetchRequest = BookmarkItemModel.fetchRequest()
        let objects = try? viewContext.fetch(fetchRequest)
        
        return objects
    }
    
    func add() -> Bool {
        let newItem = BookmarkItemModel(context: viewContext)
        newItem.timestamp = Date()
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            return false
        }
        return true
    }
    
    func delete(offsets: IndexSet) -> Bool {
        guard let items = get()
        else { return false }
        
        offsets.map { items[$0] }.forEach(viewContext.delete)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            return false
        }
        
        return true
    }
}

final class BookmarkDataSourceManager {
    private init() {}
    
    static let shared = BookmarkLocalDataSource(viewContext: BookmarkContainer.shared.container.viewContext)
}
