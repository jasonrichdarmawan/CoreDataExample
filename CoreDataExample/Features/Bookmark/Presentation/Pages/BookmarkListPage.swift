//
//  BookmarkListPage.swift
//  CoreDataExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 03/11/23.
//

import SwiftUI

struct BookmarkListPage: View {
    @ObservedObject private var viewModel: BookmarkListViewModel
    private let listID: String
    
    init(viewModel: BookmarkListViewModel, listID: String) {
        self.viewModel = viewModel
        self.listID = listID
    }
    
    var body: some View {
        List {
            ForEach(viewModel.bookmarkItems) { item in
                NavigationLink {
                    Text("TODO: Regulation / Definition Page")
                } label: {
                    Grid(alignment: .topLeading) {
                        GridRow {
                            Text("timestamp:")
                            Text("\(item.timestamp != nil ? itemFormatter.string(from: item.timestamp!) : "")")
                        }
                        GridRow {
                            Text("type:")
                            Text("\(item.type ?? "")")
                        }
                        GridRow {
                            Text("title:")
                            Text("\(item.mapTitleToString())")
                                .lineLimit(2)
                        }
                        GridRow {
                            Text("params:")
                            Text("\(item.mapParamsToString())")
                        }
                    }
                }
            }
            .onDelete { offsets in
                withAnimation {
                    let ids = offsets.compactMap { viewModel.bookmarkItems[$0].id }
                    viewModel.deleteItems(listID: listID, ids: ids)
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
                            listID: listID,
                            type: "regulation",
                            data: [
                                "title": "Undang-Undang Nomor 1 Tahun 2001 Tentang Pengesahan Persetujuan Antara Pemerintah Republik Indonesia Dan Pemerintah Hongkong Untuk Penyerahan Pelanggar Hukum Yang Melarikan Diri (Agreement Between The Government Of The Republic Of Indonesia And The Government Of Hongkong For The Surrender Of Fug",
                                "url": "uu-1-2001",
                            ]
                        )
                    }
                } label: {
                    Label("Add Regulation", systemImage: "r.circle")
                }
            }
            ToolbarItem {
                Button {
                    withAnimation {
                        viewModel.addItem(
                            listID: listID,
                            type: "definition",
                            data: [
                                "title": "Dewan Nasional",
                                "definition": "Dewan Nasional",
                                "document_id": "ad383590-0b76-11ea-9ec4-93cd37256352",
                            ]
                        )
                    }
                } label: {
                    Label("Add Definition", systemImage: "d.circle")
                }
            }
        }
        .onAppear {
            viewModel.bookmarkItems = viewModel.getItems(listID: listID)
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
        BookmarkListPage(
            viewModel: BookmarkListViewModelManager.shared,
            listID: "1"
        )
        .environment(\.managedObjectContext, BookmarkContainer.shared.container.viewContext)
    }
}
