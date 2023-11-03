//
//  AddBookmarkList.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 03/11/23.
//

import Foundation

protocol AddBookmarkList {
    func call(title: String) -> BookmarkList?
}

final class AddBookmarkListImpl: AddBookmarkList {
    private let repository: BookmarkRepository
    
    init(repository: BookmarkRepository) {
        self.repository = repository
        print("\(type(of: self)) \(#function)")
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func call(title: String) -> BookmarkList? {
        return repository.addList(title: title)
    }
}

final class AddBookmarkListManager {
    private init() {}
    
    static let shared: AddBookmarkList = AddBookmarkListImpl(
        repository: BookmarkRepositoryManager.shared
    )
}
