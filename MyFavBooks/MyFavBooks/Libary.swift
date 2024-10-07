//
//  Libary.swift
//  MyFavBooks
//
//  Created by AM Student on 9/30/24.
//

import Combine
import SwiftUI

class Library: ObservableObject {
    var sortedBooks: [Section: [Book]] {
        // Organizes books into sections based on there property
        get {
// groups books into sections  based on their property
            let groupedBooks = Dictionary(
                // maps grouped books to sections and return as dictionary
                grouping: booksCache, by: \.myFavoriteBook)
            return Dictionary(uniqueKeysWithValues: groupedBooks.map {
                // uses a ternary operator (one code is true one is false) to maps keys to correspinding section types.
                    (($0.key ? .myFavoriteBooks : .finished), $0.value)
                })
        }
        set {
            // sorts books base on their section keys
            booksCache =
                newValue
                .sorted { $1.key == .finished }
                .flatMap { $0.value }

        }

    }
    
    // sorts books and updates bookCache
    func sortBooks() {
        booksCache =
        sortedBooks
            .sorted { $1.key == .finished }
            .flatMap { $0.value }
        objectWillChange.send()
    }
    // add new book
    func addNewBook(_ book: Book, image: Image?) {
        booksCache.insert(book, at: 0)
        images[book] = image
    }
    
    // Delets books
    func deleteBooks(atOffSets offsets: IndexSet, section: Section) {
        let booksBeforeDeletion = booksCache
        
        sortedBooks[section]?.remove(atOffsets: offsets)
        
        for change in booksCache.difference(from: booksBeforeDeletion) {
            if case .remove(_, let deletedBook, _) = change {
                images[deletedBook] = nil
            }
        }
    }
    
    func moveBooks(oldOffSets: IndexSet, NewOffSet: Int, section: Section) { sortedBooks[section]?.move(fromOffsets: oldOffSets, toOffset: NewOffSet)
    }
    @Published private var booksCache: [Book] = [
        .init(title: "Born a Crime", author: "Trevor Noah"),
        .init(title: "Bossypants", author: "Tina Fey"),
        .init(title: "Ramona the Pest", author: "Beverly Cleary"),
        .init(title: "Shawhsank Depemtion", author: "Trevor Noah"),
        .init(title: "The Fault in Our Stars", author: "John Green"),
        .init(title: "The Girl on the Train", author: "Paula Hawkins"),
        .init(title: "The Lovely Bones", author: "Alica Sebold"),
        .init(title: "The Mouse and the Motorcycle", author: "Beverly Cleary"),
        .init(title: "2312", author: "Kim Stanley Robinson"),
        .init(title: "Two Against the Tide", author: "Bruce Clements"),
    ]
    @Published var images: [Book: Image] = [:]
    
    init() {
        if let dogMan = booksCache.first(where: { $0.title == "Born a Crime"}) {
            images[dogMan] = Image("dogmana")
        }
            if let dogMan = booksCache.first(where: { $0.title == "Bossypants"}) {
                images[dogMan] = Image("dogmanb")
                
            }
                    if let dogMan = booksCache.first(where: { $0.title == "Ramona the Pest"}) {
                        images[dogMan] = Image("dogmanc")
                        
                    }
                            if let dogMan = booksCache.first(where: { $0.title == "Shawhsank Depemtion"}) {
                                images[dogMan] = Image("dogmand")
                                
                            }
                                        if let dogMan = booksCache.first(where: { $0.title == "dogMan"}) {
                                            images[dogMan] = Image("dogman")
        }
    }
}
enum Section: CaseIterable {
    case myFavoriteBooks
    case finished
}
