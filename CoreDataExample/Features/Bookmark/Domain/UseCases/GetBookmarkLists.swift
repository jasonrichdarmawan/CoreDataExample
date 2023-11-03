//
//  GetBookmarkList.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import SwiftUI

protocol GetBookmarkLists {
    func call(ascending: Bool) -> [BookmarkList]
}

final class GetBookmarkListsImpl: GetBookmarkLists {
    private let repository: BookmarkRepository
    
    init(repository: BookmarkRepository) {
        self.repository = repository
        print("\(type(of: self)) \(#function)")
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func call(ascending: Bool) -> [BookmarkList] {
        return repository.getLists(ascending: ascending)
    }
}

final class GetBookmarkListManager {
    private init() {}
    
    static let shared: GetBookmarkLists = GetBookmarkListsImpl(
        repository: BookmarkRepositoryManager.shared
    )
}
