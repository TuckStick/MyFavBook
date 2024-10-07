//
//  Book.swift
//  MyFavBooks
//
//  Created by AM Student on 9/26/24.
//

import Combine

class Book: ObservableObject {
    @Published var title: String
    @Published var author: String
    @Published var microReview: String
    @Published var myFavoriteBook: Bool
    
    init(
        title: String = "Title",
        author: String = "Author",
        microReview: String = "",
        myFavoriteBook: Bool = true
        
    ) {
        self.title = title
        self.author = author
        self.microReview = microReview
        self.myFavoriteBook = myFavoriteBook
    }
    
}
// extension used to compare instances of books.
extension Book: Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        lhs === rhs
    }
}

// Ensures each Book instance can be hashed uniquely. Used in our Book Collection.
extension Book: Hashable, Identifiable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
