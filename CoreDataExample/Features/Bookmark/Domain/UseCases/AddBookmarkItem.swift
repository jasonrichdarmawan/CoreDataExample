//
//  AddBookmarkItem.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation

protocol AddBookmarkItem: AnyObject {
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
    
    static weak var shared: AddBookmarkItem! {
        var temp: AddBookmarkItem
        
        if _shared == nil {
            temp = AddBookmarkItemImpl(
                repository: BookmarkRepositoryManager.shared
            )
            _shared = temp
        }
        
        return _shared
    }
    
    private static weak var _shared: AddBookmarkItem?
}
