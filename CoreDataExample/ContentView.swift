//
//  ContentView.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello World")
                NavigationLink {
                    BookmarkPage(
                        viewModel: BookmarkViewModelManager.shared
                    )
                } label: {
                    Text("Bookmark Page")
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, BookmarkContainer.shared.container.viewContext)
}
