//
//  BookmarkRepository.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation

protocol BookmarkRepository {
    func get() -> [BookmarkItem]
    func add(type: String, data: [String: Any]) -> BookmarkItem?
    func delete(offsets: IndexSet) -> Bool
}
