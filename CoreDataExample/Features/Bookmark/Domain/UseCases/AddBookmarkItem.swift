//
//  AddBookmarkItem.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation

protocol AddBookmarkItem {
    func call(listID: String, type: String, data: [String: Any]) -> BookmarkItem?
}

final class AddBookmarkItemImpl: AddBookmarkItem {
    private let repository: BookmarkRepository
    
    init(repository: BookmarkRepository) {
        self.repository = repository
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
    }
    
    deinit {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
    }
    
    func call(listID: String, type: String, data: [String: Any]) -> BookmarkItem? {
        return repository.addItem(listID: listID, type: type, data: data)
    }
}

final class AddBookmarkItemManager {
    private init() {}
    
    static let shared: AddBookmarkItem = AddBookmarkItemImpl(
        repository: BookmarkRepositoryManager.shared
    )
}
