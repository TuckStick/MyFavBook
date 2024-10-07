//
//  DetailView.swift
//  MyFavBooks
//
//  Created by AM Student on 10/2/24.
//

import SwiftUI
import class PhotosUI.PHPickerViewController

struct DetailView: View {
    
    @ObservedObject var book: Book
    @EnvironmentObject var library: Library

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                Button {
                    book.myFavoriteBook.toggle()
                } label: {
                    Image(systemName: book.myFavoriteBook ?
                          "bookmark.fill" : "bookmark")
                    .font(.system(size: 48, weight: .light))
                }
                BookView(book: book, titleFont: .title, authorFont: .title2)
                }
            Review(book: book, image: $library.images[book])
            }
        .onDisappear{
        withAnimation {
            library.sortBooks()
        }
        }
        .padding()
    }
    
}


#Preview {
    DetailView(book: .init())
        .environmentObject(Library())
}
