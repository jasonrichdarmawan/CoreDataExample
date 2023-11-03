//
//  BookmarkItem.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import Foundation

struct BookmarkItem: Identifiable {
    let id: String?
    let timestamp: Date?
    let type: String?
    let data: [String: Any]
}

extension BookmarkItem {
    func mapTitleToString() -> String {
        return data["title"] as? String ?? ""
    }
    
    func mapParamsToString() -> String {
        let result: String
        
        switch type {
        case "regulation":
            result = "url: \(data["url"] as? String ?? "")"
            
            return result
        case "definition":
            result = "document_id: \(data["document_id"] as? String ?? "") definition: \(data["definition"] as? String ?? "")"
            
            return result
        default:
            return ""
        }
    }
}
