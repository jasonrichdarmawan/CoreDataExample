//
//  CoreDataExampleApp.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import SwiftUI

@main
struct CoreDataExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, BookmarkContainer.shared.container.viewContext)
        }
    }
}
