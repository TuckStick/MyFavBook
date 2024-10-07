import SwiftUI

struct BookView: View {
    
    let book: Book
    let titleFont: Font
    let authorFont: Font
    
            
            var body: some View {
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(titleFont)
                    Text(book.author)
                        .font(authorFont)
                }
            }
        }
    


        extension Book {
            
            struct Image: View {
                let image: SwiftUI.Image?
                let title: String
                var size: CGFloat?
                let cornerRadius: CGFloat
                
                var body: some View {
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: size, height: size)
                            .cornerRadius(cornerRadius)
                    } else {
                        // generates imagine
                        
                        let symbol = SwiftUI.Image(title: title)
                        ??
                            .init(systemName: "book")
                        
                        symbol
                            .resizable()
                            .scaledToFit()
                            .frame(width: size, height: size)
                            .font(Font.title.weight(.light))
                            .foregroundColor(.secondary.opacity(0.5))
                     }
                    }
                    
                }
            }

extension Image {
    init?(title: String) {
        guard let character = title.first,
    case let symbolName = "\(character.lowercased()).square",
        UIImage(systemName: symbolName) != nil
        else {
            return nil
        }
        self.init(systemName: symbolName)
        
    }
}

extension Book.Image {
    init(title: String) {
        self.init(image: nil, title: title, cornerRadius: .init())
    }
}

#Preview {
    VStack {
        BookView(book: .init(), titleFont: .title, authorFont: .title2)
        Book.Image(title: Book().title)
        Book.Image(title: "")
        Book.Image(title: "📖")
    }
}
