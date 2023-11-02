//
//  BookmarkItem.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation

struct BookmarkItem: Identifiable {
    let id: ObjectIdentifier
    let timestamp: Date?
    let type: String?
    let data: [String: Any]
}
