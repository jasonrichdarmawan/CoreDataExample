//
//  AddBookmarkList.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 03/11/23.
//

import Foundation

protocol AddBookmarkList: AnyObject {
    func call(title: String) -> BookmarkList?
}

final class AddBookmarkListImpl: AddBookmarkList {
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
    
    func call(title: String) -> BookmarkList? {
        return repository.addList(title: title)
    }
}

final class AddBookmarkListManager {
    private init() {}
    
    static weak var shared: AddBookmarkList! {
        var temp: AddBookmarkList
        
        if _shared == nil {
            temp = AddBookmarkListImpl(
                repository: BookmarkRepositoryManager.shared
            )
            _shared = temp
        }
        
        return _shared
    }
    
    static weak var _shared: AddBookmarkList?
}
