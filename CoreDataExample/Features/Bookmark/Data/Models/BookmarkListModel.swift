//
//  BookmarkListModel.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 03/11/23.
//

import Foundation

extension BookmarkListModel {
    func toDomain() -> BookmarkList {
        return BookmarkList(
            id: self.id,
            timestamp: self.timestamp,
            data: [
                "title": self.title as Any,
            ]
        )
    }
}
