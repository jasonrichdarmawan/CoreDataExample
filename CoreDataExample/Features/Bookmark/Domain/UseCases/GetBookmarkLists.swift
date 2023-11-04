//
//  GetBookmarkList.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import SwiftUI

protocol GetBookmarkLists: AnyObject {
    func call(ascending: Bool) -> [BookmarkList]
}

final class GetBookmarkListsImpl: GetBookmarkLists {
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
    
    func call(ascending: Bool) -> [BookmarkList] {
        return repository.getLists(ascending: ascending)
    }
}

final class GetBookmarkListManager {
    private init() {}
    
    static weak var shared: GetBookmarkLists! {
        var temp: GetBookmarkLists
        
        if _shared == nil {
            temp = GetBookmarkListsImpl(
                repository: BookmarkRepositoryManager.shared
            )
            _shared = temp
        }
        
        return _shared
    }
    
    static weak var _shared: GetBookmarkLists?
}
