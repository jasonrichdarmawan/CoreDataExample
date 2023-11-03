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
            ForEach(viewModel.bookmarkLists) { list in
                NavigationLink {
                    BookmarkListPage(
                        viewModel: BookmarkListViewModelManager.shared,
                        listID: list.id ?? ""
                    )
                } label: {
                    VStack(alignment: .leading) {
                        Text("timestamp: \(list.timestamp ?? Date(), formatter: itemFormatter)")
                        HStack(alignment: .top) {
                            Text("title:")
                            Text("\(list.mapTitleToString())")
                                .lineLimit(1)
                        }
                    }
                }
            }
            .onDelete { offsets in
                withAnimation {
                    let ids = offsets.compactMap { viewModel.bookmarkLists[$0].id }
                    viewModel.deleteLists(ids: ids)
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
                        viewModel.addList(
                            title: "List \(UUID().uuidString.prefix(3))"
                        )
                    }
                } label: {
                    Label("Add List", systemImage: "plus")
                }
            }
        }
        .onAppear {
            #if DEBUG
            print("\(type(of: self)) onAppear")
            #endif
            viewModel.bookmarkLists = viewModel.getList()
        }
        .onDisappear {
            #if DEBUG
            print("\(type(of: self)) onDisappear")
            #endif
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
