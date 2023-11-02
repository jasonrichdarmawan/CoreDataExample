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

extension BookmarkItem {
    func mapDataToString() -> String {
        switch type {
        case "regulation":
            return data["url"] as? String ?? ""
        case "definition":
            return data["document_id"] as? String ?? ""
        default:
            return ""
        }
    }
}
