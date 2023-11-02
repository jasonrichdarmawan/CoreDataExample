//
//  BookmarkPage.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/11/23.
//

import SwiftUI

struct BookmarkPage: View {    
    @ObservedObject var viewModel: BookmarkViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.bookmarkList) { item in
                NavigationLink {
                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                } label: {
                    Text(item.timestamp!, formatter: itemFormatter)
                }
            }
            .onDelete { offsets in
                withAnimation {
                    viewModel.deleteItems(offsets: offsets)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button {
                    withAnimation {
                        viewModel.addItem()
                    }
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


#Preview {
    NavigationView {
        BookmarkPage(
            viewModel: BookmarkViewModelManager.shared
        )
        .environment(\.managedObjectContext, BookmarkContainer.shared.container.viewContext)
    }
}
