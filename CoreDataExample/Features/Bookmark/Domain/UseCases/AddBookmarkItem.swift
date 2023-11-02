//
//  AddBookmarkItem.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation

protocol AddBookmarkItem {
    func call(type: String, data: [String: Any]) -> Bool
}

final class AddBookmarkItemImpl: AddBookmarkItem {
    private let repository: BookmarkRepository
    
    init(repository: BookmarkRepository) {
        self.repository = repository
    }
    
    func call(type: String, data: [String: Any]) -> Bool {
        return repository.add(type: type, data: data)
    }
}

final class AddBookmarkItemManager {
    private init() {}
    
    static let shared = AddBookmarkItemImpl(repository: BookmarkRepositoryManager.shared)
}
