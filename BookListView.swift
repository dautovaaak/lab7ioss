import SwiftUI

struct BookListView: View {
    @Binding var books: [Book]
    var bookFetcher: BookFetcher // Remove onAddToLibrary argument
    
    var body: some View {
        NavigationView {
            List(books) { book in
                NavigationLink(destination: BookDetailView(book: book, bookFetcher: bookFetcher)) {
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text("By: \(book.authors.joined(separator: ", "))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationBarTitle("My Books")
        }
    }
}
