//
//  BookmarItem.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation

extension BookmarkItemModel {
    func toDomain() -> BookmarkItem {
        return BookmarkItem(
            id: self.id,
            timestamp: self.timestamp,
            type: self.type,
            data: self.changedValues()
        );
    }
}
