//
//  BookmarkListViewModel.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 03/11/23.
//

import Foundation

final class BookmarkListViewModel: ObservableObject {
    @Published var bookmarkItems: [BookmarkItem]
    
    private let getBookmarkItems: GetBookmarkItems
    private let addBookmarkItem: AddBookmarkItem
    private let deleteBookmarkItemsByIDs: DeleteBookmarkItemsByIDs
    
    init(
        getBookmarkItems: GetBookmarkItems,
        addBookmarkItem: AddBookmarkItem,
        deleteBookmarkItemsByIDs: DeleteBookmarkItemsByIDs
    ) {
        self.bookmarkItems = []
        self.getBookmarkItems = getBookmarkItems
        self.addBookmarkItem = addBookmarkItem
        self.deleteBookmarkItemsByIDs = deleteBookmarkItemsByIDs
    }
    
    func getItems(listID: String, ascending: Bool = false) -> [BookmarkItem] {
        print("\(type(of: self)) \(#function) \(listID)")
        return getBookmarkItems.call(listID: listID, ascending: ascending)
    }
    
    // TECHDEBT: call initState everytime the datasource updates.
    func addItem(listID: String, type: String, data: [String: Any]) {
        guard let newItem = addBookmarkItem.call(listID: listID, type: type, data: data) else { return }
        bookmarkItems.append(newItem)
        bookmarkItems.sort { $0.timestamp ?? Date() > $1.timestamp ?? Date() }
    }
    
    func deleteItems(listID: String, ids: [String]) {
        _ = deleteBookmarkItemsByIDs.call(listID: listID, ids: ids)
        bookmarkItems = bookmarkItems.filter {
            guard let id = $0.id else { return true }
            return !ids.contains(id)
        }
    }
}

final class BookmarkListViewModelManager {
    private init() {}
    
    static let shared = BookmarkListViewModel(
        getBookmarkItems: GetBookmarkItemsManager.shared,
        addBookmarkItem: AddBookmarkItemManager.shared,
        deleteBookmarkItemsByIDs: DeleteBookmarkItemsByIDsManager.shared
    )
}
