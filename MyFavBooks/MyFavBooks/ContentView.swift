//
//  ContentView.swift
//  MyFavBooks
//
//  Created by AM Student on 9/26/24.
//

import SwiftUI

struct ContentView: View {
    @State var addNewBook = false
    @EnvironmentObject var libary: Library
    var body: some View {
        NavigationView {
            List {

                Button {
                    addNewBook = true
                } label: {
                    Spacer()
                    VStack(spacing: 6) {
                        Image(systemName: "book.circle")
                            .font(.system(size: 60))
                        Text("Add New Book")
                            .font(.title2)
                    }
                    Spacer()

                }
                .buttonStyle(.borderless)
                .padding(.vertical, 8)
                .sheet(isPresented: $addNewBook, content: NewBookView.init)
                
                ForEach(Section.allCases, id: \.self) {
                    SectionView(section: $0)
                }
            }
            
            .listStyle(.insetGrouped)
            .toolbar(content: EditButton.init)
            .navigationTitle("My Favorite Books")

        }
    }
}

struct BookRow: View {

    @ObservedObject var book: Book
    @EnvironmentObject var library: Library
    var body: some View {
        NavigationLink(
            destination: DetailView(book: book)
        ) {
            HStack {
                Book.Image(
                    image: library.images[book], title: book.title, size: 80,
                    cornerRadius: 12)
                VStack(alignment: .leading) {
                    BookView(
                        book: book, titleFont: .title2, authorFont: .title3)
                    if !book.microReview.isEmpty {
                        Spacer()
                        Text(book.microReview)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .lineLimit(1)
            }
        }
        .padding(.vertical)
    }
}
private struct SectionView: View {
    let section: Section
    @EnvironmentObject var library: Library
    var title: String {
        switch section {
        case .myFavoriteBooks:
            return "Reading List"
        case .finished:
            return "Finished"
        }
    }

    var body: some View {
        if let books = library.sortedBooks[section] {
            SwiftUI.Section {
                ForEach(books) { book in
                    BookRow(book: book)
                        .swipeActions(edge: .leading) {
                            Button {
                                withAnimation {
                                    book.myFavoriteBook.toggle()
                                    library
                                        .sortBooks()
                                }
                            } label: {
                                book.myFavoriteBook
                                    ? Label(
                                        "Finished",
                                        systemImage: "bookmark.slash")
                                    : Label(
                                        "Reading List", systemImage: "bookmark")

                            }
                            .tint(.accentColor)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                guard
                                    let index = books.firstIndex(where: {
                                        $0.id == book.id
                                    })
                                else {
                                    return
                                }
                                withAnimation {
                                    library.deleteBooks(
                                        atOffSets:
                                            .init(integer: index),
                                        section: section)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
                .onDelete {
                    indexSet in
                    library.deleteBooks(atOffSets: indexSet, section: section)
                }
                .onMove {
                    indexes, newOffset in
                    library.moveBooks(
                        oldOffSets: indexes, NewOffSet: newOffset,
                        section: section)
                }
                .labelStyle(.iconOnly)
            } header: {
                ZStack {
                    Image("LightTexture")
                        .resizable()
                        .scaledToFit()

                    Text(title)
                        .font(.custom("American Typewrite", size: 24))
                }
                .listRowInsets(.init())
            }
        }
    }
}
#Preview {
    ContentView()
        .environmentObject(Library())
}
