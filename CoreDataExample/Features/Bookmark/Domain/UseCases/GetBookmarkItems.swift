//
//  GetBookmarkItems.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 03/11/23.
//

import Foundation

protocol GetBookmarkItems {
    func call(listID: String, ascending: Bool) -> [BookmarkItem]
}

final class GetBookmarkItemsImpl: GetBookmarkItems {
    private let repository: BookmarkRepository
    
    init(repository: BookmarkRepository) {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
        self.repository = repository
    }
    
    deinit {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
    }
    
    func call(listID: String, ascending: Bool) -> [BookmarkItem] {
        return repository.getItems(listID: listID, ascending: ascending)
    }
}

final class GetBookmarkItemsManager {
    static let shared: GetBookmarkItems = GetBookmarkItemsImpl(
        repository: BookmarkRepositoryManager.shared
    )
}
