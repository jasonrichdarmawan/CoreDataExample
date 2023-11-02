//
//  BookmarkRepository.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation

protocol BookmarkRepository {
    func get() -> [BookmarkItem]
    func add() -> Bool
    func delete(offsets: IndexSet) -> Bool
}
