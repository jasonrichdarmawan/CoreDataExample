//
//  BookmarkDataSource.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation
import CoreData

protocol BookmarkDataSource: AnyObject {
    func getLists(ascending: Bool) -> [BookmarkListModel]?
    func addList(title: String) -> BookmarkListModel?
    func deleteLists(ids: [String]) -> Bool
 
    func getItems(listID: String, ascending: Bool) -> [BookmarkItemModel]?
    func addItem(listID: String, type: String, data: [String: Any]) -> BookmarkItemModel?
    func deleteItems(listID: String, ids: [String]) -> Bool
}

final class BookmarkCloudKitDataSource: BookmarkDataSource {
    private var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
        self.viewContext = viewContext
    }
    
    deinit {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
    }
    
    func getLists(ascending: Bool = false) -> [BookmarkListModel]? {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
        let fetchRequest = BookmarkListModel.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \BookmarkListModel.timestamp, ascending: ascending)
        ]
        let objects = try? viewContext.fetch(fetchRequest)
        
        return objects
    }
    
    func getList(listID: String) -> BookmarkListModel? {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
        let fetchRequest = BookmarkListModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", listID)
        
        let objects = try? viewContext.fetch(fetchRequest)
        
        return objects?[0]
    }
    
    func addList(title: String) -> BookmarkListModel? {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
        let newList = BookmarkListModel(context: viewContext)
        newList.id = UUID().uuidString
        newList.timestamp = Date()
        newList.title = title
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            return nil
        }
        return newList
    }
    
    func deleteLists(ids: [String]) -> Bool {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
        guard let items = getLists()
        else { return false }
        
        items.filter { item in
            guard let id = item.id else { return false }
            return ids.contains(id)
        }.forEach(viewContext.delete)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            return false
        }
        
        return true
    }
    
    func getItems(listID: String, ascending: Bool = false) -> [BookmarkItemModel]? {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
        let fetchRequest = BookmarkItemModel.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \BookmarkItemModel.timestamp, ascending: ascending)
        ]
        fetchRequest.predicate = NSPredicate(format: "list.id = %@", listID)
        let objects = try? viewContext.fetch(fetchRequest)
        
        return objects
    }
    
    func addItem(listID: String, type: String, data: [String: Any]) -> BookmarkItemModel? {
        #if DEBUG
        print("\(String(describing: self)) \(#function)")
        #endif
        let newItem = BookmarkItemModel(context: viewContext)
        newItem.timestamp = Date()
        newItem.id = UUID().uuidString
        newItem.type = type
        newItem.list = getList(listID: listID)
        
        switch type {
        case "regulation":
            newItem.title = data["title"] as? String
            newItem.url = data["url"] as? String
            break
        case "definition":
            newItem.title = data["title"] as? String
            newItem.document_id = data["document_id"] as? String
            newItem.definition = data["definition"] as? String
            break
        default:
            return nil
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            return nil
        }
        return newItem
    }
    
    func deleteItems(listID: String, ids: [String]) -> Bool {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
        guard let items = getItems(listID: listID)
        else { return false }
        
        items.filter { item in
            guard let id = item.id else { return false }
            return ids.contains(id)
        }.forEach(viewContext.delete)
        
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
    
    static weak var shared: BookmarkDataSource! {
        var temp: BookmarkDataSource
        
        if _shared == nil {
            temp = BookmarkCloudKitDataSource(
                viewContext: BookmarkContainer.shared.container.viewContext
            )
            _shared = temp
        }
        
        return _shared
    }
    
    private static weak var _shared: BookmarkDataSource?
}
