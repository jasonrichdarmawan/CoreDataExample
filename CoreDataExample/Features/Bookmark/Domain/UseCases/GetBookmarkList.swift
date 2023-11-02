//
//  GetBookmarkList.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import SwiftUI

protocol GetBookmarkList {
    func call() -> [BookmarkItem]
}

final class GetBookmarkListImpl: GetBookmarkList {
    private let repository: BookmarkRepository
    
    init(repository: BookmarkRepository) {
        self.repository = repository
        print("\(type(of: self)) \(#function)")
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func call() -> [BookmarkItem] {
        return repository.get()
    }
}

final class GetBookmarkListManager {
    private init() {}
    
    static let shared = GetBookmarkListImpl(repository: BookmarkRepositoryManager.shared)
}
