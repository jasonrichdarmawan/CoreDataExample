//
//  BookmarkViewModel.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation

final class BookmarkViewModel: ObservableObject {
    @Published var bookmarkLists: [BookmarkList]
    
    private let getBookmarkList: GetBookmarkLists
    private let addBookmarkList: AddBookmarkList
    private let deleteBookmarkLists: DeleteBookmarkListsByIDs
    
    init(
        getBookmarkList: GetBookmarkLists,
        addBookmarkList: AddBookmarkList,
        deleteBookmarkLists: DeleteBookmarkListsByIDs
    ) {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
        self.bookmarkLists = []
        
        self.getBookmarkList = getBookmarkList
        self.addBookmarkList = addBookmarkList
        self.deleteBookmarkLists = deleteBookmarkLists
    }
    
    deinit {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
    }
    
    func getList(ascending: Bool = false) -> [BookmarkList] {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
        return getBookmarkList.call(ascending: ascending)
    }
    
    // TECHDEBT: update bookmarkList manually
    func addList(title: String) {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
        guard let newList = addBookmarkList.call(title: title) else { return }
        bookmarkLists.append(newList)
        bookmarkLists.sort { $0.timestamp ?? Date() > $1.timestamp ?? Date() }
    }
    
    func deleteLists(ids: [String]) {
        #if DEBUG
        print("\(type(of: self)) \(#function)")
        #endif
        _ = deleteBookmarkLists.call(ids: ids)
        bookmarkLists = bookmarkLists.filter { item in
            guard let id = item.id else { return true }
            return !ids.contains(id)
        }
    }
}

final class BookmarkViewModelManager {
    private init() {}
    
    static weak var shared: BookmarkViewModel! {
        var temp: BookmarkViewModel
        
        if _shared == nil {
            temp = BookmarkViewModel(
                getBookmarkList: GetBookmarkListManager.shared,
                addBookmarkList: AddBookmarkListManager.shared,
                deleteBookmarkLists: DeleteBookmarkListsManager.shared
            )
            _shared = temp
        }
        
        return _shared
    }
    
    private static weak var _shared: BookmarkViewModel?
}
