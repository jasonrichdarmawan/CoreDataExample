//
//  BookmarkRepositoryImpl.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import SwiftUI

final class BookmarkRepositoryImpl: BookmarkRepository {
    private let dataSource: BookmarkDataSource
    
    init(dataSource: BookmarkDataSource) {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
        self.dataSource = dataSource
    }
    
    deinit {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
    }
    
    func getLists(ascending: Bool) -> [BookmarkList] {
        print("\(BookmarkRepositoryImpl.self) \(#function)")
        return dataSource.getLists(ascending: ascending)?.map { $0.toDomain() } ?? []
    }
    
    func addList(title: String) -> BookmarkList? {
        return dataSource.addList(title: title)?.toDomain()
    }
    
    func deleteLists(ids: [String]) -> Bool {
        return dataSource.deleteLists(ids: ids)
    }
    
    func getItems(listID: String, ascending: Bool) -> [BookmarkItem] {
        return dataSource.getItems(listID: listID, ascending: ascending)?.map { $0.toDomain() } ?? []
    }
    
    func addItem(listID: String, type: String, data: [String: Any]) -> BookmarkItem? {
        return dataSource.addItem(listID: listID, type: type, data: data)?.toDomain()
    }
    
    func deleteItems(listID: String, ids: [String]) -> Bool {
        return dataSource.deleteItems(listID: listID, ids: ids)
    }
}

final class BookmarkRepositoryManager {
    private init() {}
    
    static weak var shared: BookmarkRepository! {
        var temp: BookmarkRepository
        
        if _shared == nil {
            temp = BookmarkRepositoryImpl(
                dataSource: BookmarkDataSourceManager.shared
            )
            _shared = temp
        }
        
        return _shared
    }
    
    private static weak var _shared: BookmarkRepository?
}
