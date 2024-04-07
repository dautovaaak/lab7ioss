import SwiftUI

struct BookDetailView: View {
    let book: Book
    let onAddToLibrary: (Book) -> Void
    
    var body: some View {
        VStack {
            Text(book.title)
                .font(.title)
                .padding()
            
            Text("By: \(book.authors.joined(separator: ", "))")
                .font(.subheadline)
                .padding()
            
            Button(action: {
                // Call the closure to add the book to the library
                onAddToLibrary(book)
            }) {
                Text("Add to Library")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer()
        }
        .navigationBarTitle("Book Detail")
    }
}
