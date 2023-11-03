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
    
    func get() -> [BookmarkItem] {
        print("\(BookmarkRepositoryImpl.self) \(#function)")
        return dataSource.get()?.map { $0.toDomain() } ?? []
    }
    
    func add(type: String, data: [String: Any]) -> BookmarkItem? {
        return dataSource.add(type: type, data: data)?.toDomain()
    }
    
    func delete(offsets: IndexSet) -> Bool {
        return dataSource.delete(offsets: offsets)
    }
}

final class BookmarkRepositoryManager {
    private init() {}
    
    static let shared = BookmarkRepositoryImpl(dataSource: BookmarkDataSourceManager.shared)
}
