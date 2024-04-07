import SwiftUI
import Combine

class BookFetcher: ObservableObject {
    @Published var query: String = ""
    @Published var manuallyAddedBooks: [Book] = []
    @Published var books: [Book] = []
    @Published var showAlert: Bool = false
    @Published var selectedBook: Book?
    private var bookDatabase = BookDatabase()
    
    init(bookDatabase: BookDatabase) {
        self.bookDatabase = bookDatabase
    }
    
    func addBookToLibrary(_ book: Book) {
        manuallyAddedBooks.append(book)
    }
    
    func fetchBooks(query: String) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(encodedQuery)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let bookResponse = try? JSONDecoder().decode(BookResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.books = bookResponse.items
                }
            }
        }.resume()
    }
}
