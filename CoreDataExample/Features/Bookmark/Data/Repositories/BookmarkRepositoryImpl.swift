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
        self.dataSource = dataSource
        print("\(type(of: self)) \(#function)")
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
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
    
    static let shared = BookmarkRepositoryImpl(dataSource: BookmarkDataSourceManager.shared)
}
