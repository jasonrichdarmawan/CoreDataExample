//
//  DeleteBookmarkItems.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation

protocol DeleteBookmarkItems {
    func call(offsets: IndexSet)
}

final class DeleteBookmarkItemsImpl: DeleteBookmarkItems {
    private let repository: BookmarkRepository
    
    init(repository: BookmarkRepository) {
        self.repository = repository
    }
    
    func call(offsets: IndexSet) {
        _ = self.repository.delete(offsets: offsets)
    }
}

final class DeleteBookmarkItemsManager {
    private init() {}
    
    static let shared = DeleteBookmarkItemsImpl(repository: BookmarkRepositoryManager.shared)
}
