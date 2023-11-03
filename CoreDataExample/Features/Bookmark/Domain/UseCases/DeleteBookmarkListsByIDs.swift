//
//  DeleteBookmarkList.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 03/11/23.
//

import Foundation

protocol DeleteBookmarkListsByIDs {
    func call(ids: [String])
}

final class DeleteBookmarkListsByIDsImpl: DeleteBookmarkListsByIDs {
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
    
    func call(ids: [String]) {
        _ = repository.deleteLists(ids: ids)
    }
}

final class DeleteBookmarkListsManager {
    private init() {}
    
    static let shared: DeleteBookmarkListsByIDs = DeleteBookmarkListsByIDsImpl(
        repository: BookmarkRepositoryManager.shared
    )
}
