//
//  BookmarItem.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation

extension BookmarkItemModel {
    func toDomain() -> BookmarkItem {
        let data: [String: Any]
        
        switch type {
        case "regulation":
            data = [
                "url": self.data as Any
            ]
            break;
        case "definition":
            data = [
                "document_id": self.data as Any
            ]
            break;
        default:
            data = [:]
            break;
        }
        
        return BookmarkItem(
            id: self.id,
            timestamp: self.timestamp,
            type: self.type,
            data: data
        );
    }
}
