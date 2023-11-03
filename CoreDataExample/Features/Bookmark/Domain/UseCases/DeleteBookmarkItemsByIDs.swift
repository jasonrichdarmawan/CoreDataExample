//
//  DeleteBookmarkItem.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 04/11/23.
//

import Foundation

protocol DeleteBookmarkItemsByIDs {
    func call(listID: String, ids: [String])
}

final class DeleteBookmarkItemImpl: DeleteBookmarkItemsByIDs {
    private let repository: BookmarkRepository
    
    init(repository: BookmarkRepository) {
        self.repository = repository
        print("\(type(of: self)) \(#function)")
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func call(listID: String, ids: [String]) {
        _ = self.repository.deleteItems(listID: listID, ids: ids)
    }
}

final class DeleteBookmarkItemsByIDsManager {
    private init() {}
    
    static let shared: DeleteBookmarkItemsByIDs = DeleteBookmarkItemImpl(
        repository: BookmarkRepositoryManager.shared
    )
}
