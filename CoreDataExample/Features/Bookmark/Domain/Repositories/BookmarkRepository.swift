//
//  BookmarkRepository.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation

protocol BookmarkRepository {
    func getLists(ascending: Bool) -> [BookmarkList]
    func addList(title: String) -> BookmarkList?
    func deleteLists(ids: [String]) -> Bool
    
    func getItems(listID: String, ascending: Bool) -> [BookmarkItem]
    func addItem(listID: String, type: String, data: [String: Any]) -> BookmarkItem?
    func deleteItems(listID: String, ids: [String]) -> Bool
}
