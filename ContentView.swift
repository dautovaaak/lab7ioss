import SwiftUI

struct ContentView: View {
    @ObservedObject var bookFetcher = BookFetcher(bookDatabase: BookDatabase())
    
    var body: some View {
        TabView {
            NavigationView {
                BookListView(books: $bookFetcher.books, onAddToLibrary: { _ in })
            }
            .tabItem {
                Image(systemName: "book")
                Text("My Library")
            }
            
            NavigationView {
                SearchBooksView(bookFetcher: bookFetcher)
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search Books")
            }
        }
    }
}
