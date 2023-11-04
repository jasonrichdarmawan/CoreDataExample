//
//  DeleteBookmarkList.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 03/11/23.
//

import Foundation

protocol DeleteBookmarkListsByIDs: AnyObject {
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
    
    static weak var shared: DeleteBookmarkListsByIDs! {
        var temp: DeleteBookmarkListsByIDs
        
        if _shared == nil {
            temp = DeleteBookmarkListsByIDsImpl(
                repository: BookmarkRepositoryManager.shared
            )
            _shared = temp
        }
        
        return _shared
    }
    
    private static weak var _shared: DeleteBookmarkListsByIDs?
}
