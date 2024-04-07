import SwiftUI

struct AddBookView: View {
    @ObservedObject var bookFetcher: BookFetcher
    @State private var rating = 0
    
    var body: some View {
        VStack {
            Stepper(value: $rating, in: 0...5, step: 1) {
                Text("Rating: \(rating)")
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                addBook()
            }) {
                Text("Add Book")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
        .transition(.slide)
    }
    
    func addBook() {
        if let selectedBook = bookFetcher.selectedBook { // Use optional binding to access selectedBook
            let newBook = Book(id: UUID().uuidString, title: selectedBook.title, authors: selectedBook.authors, rating: rating)
            bookFetcher.addBookToLibrary(newBook)
        }
    }
}
