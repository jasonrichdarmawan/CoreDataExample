//
//  GetBookmarkItems.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 03/11/23.
//

import Foundation

protocol GetBookmarkItems: AnyObject {
    func call(listID: String, ascending: Bool) -> [BookmarkItem]
}

final class GetBookmarkItemsImpl: GetBookmarkItems {
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
    
    func call(listID: String, ascending: Bool) -> [BookmarkItem] {
        return repository.getItems(listID: listID, ascending: ascending)
    }
}

final class GetBookmarkItemsManager {
    static weak var shared: GetBookmarkItems! {
        var temp: GetBookmarkItems
        
        if _shared == nil {
            temp = GetBookmarkItemsImpl(
                repository: BookmarkRepositoryManager.shared
            )
            _shared = temp
        }
        
        return _shared
    }
    
    private static weak var _shared: GetBookmarkItems?
}
