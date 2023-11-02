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
                    VStack {
                        Text("timestamp: \(item.timestamp!, formatter: itemFormatter)")
                        Text("type: \(item.type ?? "")")
                        Text("data: \(item.mapDataToString())")
                    }
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
                        viewModel.addItem(
                            type: "regulation",
                            data: [
                                "url": UUID().uuidString,
                            ]
                        )
                    }
                } label: {
                    Label("Add Regulation", systemImage: "a.circle")
                }
            }
            ToolbarItem {
                Button {
                    withAnimation {
                        viewModel.addItem(
                            type: "definition",
                            data: [
                                "document_id": UUID().uuidString,
                            ]
                        )
                    }
                } label: {
                    Label("Add Definition", systemImage: "b.circle")
                }
            }
        }
        .onAppear {
            viewModel.bookmarkList = viewModel.getItems()
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
