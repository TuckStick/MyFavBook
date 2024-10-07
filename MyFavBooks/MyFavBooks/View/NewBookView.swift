//
//  NewBookView.swift
//  MyFavBooks
//
//  Created by AM Student on 10/2/24.
//

import SwiftUI

struct NewBookView: View {
    
    @ObservedObject var book = Book(title: "", author: "")
    @State var image: Image? = nil
    @EnvironmentObject var library: Library
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                TextField("Title", text: $book.author)
                Review(book: book, image: $image)
            }
            .padding()
            .navigationTitle("Got a new book?")
            .toolbar {
                ToolbarItem(placement: .status) {
                    Button("Add to Library") {
                        library.addNewBook(book, image: image)
                        dismiss()
                    }
                    .disabled(
                        [book.title, book.author]
                            .contains(where: \.isEmpty)
                        )
                    }
                }
            }
        }
    }


#Preview {
    NewBookView()
}
