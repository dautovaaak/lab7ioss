import SwiftUI

struct SearchBooksView: View {
    @ObservedObject var bookFetcher: BookFetcher
    @State private var selectedBook: Book? = nil
    
    var body: some View {
        VStack {
            List(bookFetcher.books) { book in
                Button(action: {
                    selectedBook = book
                }) {
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text("By: \(book.authors.joined(separator: ", "))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .sheet(item: $selectedBook) { book in
                BookDetailView(book: $selectedBook, bookFetcher: bookFetcher)
            }
            .navigationBarTitle("Search Books")
            .searchable(text: $bookFetcher.query, prompt: "Search books...")
            .onChange(of: bookFetcher.query) { newValue in
                bookFetcher.fetchBooks(query: newValue)
            }
        }
    }
}

