//
//  BookmarkViewModel.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation

final class BookmarkViewModel: ObservableObject {
    @Published var bookmarkList: [BookmarkItem]
    
    private let getBookmarkList: GetBookmarkList
    private let addBookmarkItem: AddBookmarkItem
    private let deleteBookmarkItems: DeleteBookmarkItems
    
    init(
        getBookmarkList: GetBookmarkList,
        addBookmarkItem: AddBookmarkItem,
        deleteBookmarkItems: DeleteBookmarkItems
    ) {
        print("\(type(of: self)) \(#function)")
        self.getBookmarkList = getBookmarkList
        self.addBookmarkItem = addBookmarkItem
        self.deleteBookmarkItems = deleteBookmarkItems
        self.bookmarkList = getBookmarkList.call()
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    private func initState() -> [BookmarkItem] {
        print("\(BookmarkViewModel.self) \(#function)")
        return getBookmarkList.call()
    }
    
    // TECHDEBT: call initState everytime the datasource updates.
    func addItem() {
        _ = addBookmarkItem.call()
        bookmarkList = initState()
    }
    
    // TECHDEBT: call initState everytime the datasource updates.
    func deleteItems(offsets: IndexSet) {
        _ = deleteBookmarkItems.call(offsets: offsets)
        bookmarkList = initState()
    }
}

final class BookmarkViewModelManager {
    static let shared = BookmarkViewModel(
        getBookmarkList: GetBookmarkListManager.shared,
        addBookmarkItem: AddBookmarkItemManager.shared,
        deleteBookmarkItems: DeleteBookmarkItemsManager.shared
    )
}