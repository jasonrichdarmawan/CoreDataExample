//
//  BookmarkList.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 03/11/23.
//

import Foundation

struct BookmarkList: Identifiable {
    let id: String?
    let timestamp: Date?
    let data: [String: Any]
}

extension BookmarkList {
    func mapTitleToString() -> String {
        return data["title"] as? String ?? ""
    }
}
