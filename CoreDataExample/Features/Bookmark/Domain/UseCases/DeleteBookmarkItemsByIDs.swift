//
//  DeleteBookmarkItem.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 04/11/23.
//

import Foundation

protocol DeleteBookmarkItemsByIDs: AnyObject {
    func call(listID: String, ids: [String])
}

final class DeleteBookmarkItemByIDsImpl: DeleteBookmarkItemsByIDs {
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
    
    func call(listID: String, ids: [String]) {
        _ = self.repository.deleteItems(listID: listID, ids: ids)
    }
}

final class DeleteBookmarkItemsByIDsManager {
    private init() {}
    
    static weak var shared: DeleteBookmarkItemsByIDs! {
        var temp: DeleteBookmarkItemsByIDs
        
        if _shared == nil {
            temp = DeleteBookmarkItemByIDsImpl(
                repository: BookmarkRepositoryManager.shared
            )
            _shared = temp
        }
        
        return _shared
    }
    
    private static weak var _shared: DeleteBookmarkItemsByIDs?
}
