//
//  ContentView.swift
//  FriendsFavoritesMovies
//
//  Created by Tony Gultom on 13/08/24.
//

import SwiftUI
import SwiftData

struct MovieList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var movies: [Movie]
    
    @State private var newMovie: Movie?
    
    let enableToolbar: Bool
    
    
    /*
     
     You use predicates to describe conditions for SwiftData to filter data.
     A Query applies its predicate to each of the items in the data store. Returning true from a predicate indicates that you want to see the item.
     */
    init(titleFilter: String = "", enableToolbar: Bool = false) {
       
        /*
         The || is the logical “or” operator. You can read the entire predicate like this: 
         “Include the movie if the title filter is empty or if the title contains the text in the filter.”
         */
        let predicate = #Predicate<Movie>{movie in  titleFilter.isEmpty || movie.title.localizedStandardContains(titleFilter)}
        
        _movies = Query(filter: predicate, sort: \Movie.title)
        
        self.enableToolbar = enableToolbar
        
    }

    var body: some View {
        NavigationSplitView {
            /*
             A Group is a simple container view that doesn’t alter its contents in any way.
             
             It’s useful for wrapping conditionals and applying common modifiers to many views at once.
             */
            Group {
                
                if(!movies.isEmpty) {
                    List {
                        ForEach(movies) { movie in
                            NavigationLink {
                                MovieDetail(movie: movie, isNew: false)
                            } label: {
                                Text(movie.releaseDate, format: Date.FormatStyle(date: .numeric, time: .standard))
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                } else {
                    /*
                     when there are no movies.
                     */
                    ContentUnavailableView {

                                          Label("No Movies", systemImage: "film.stack")

                                      }
                }
            }
            
            .navigationTitle("Movies")
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)

        
            .toolbar {

                
                if(enableToolbar == true) {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
    
                    ToolbarItem {
                        Button(action: self.addMovie) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                
                
                
            }.sheet(item: $newMovie) { movie in
                    /*
                     bottom sheet
                     */
                NavigationStack {
                    MovieDetail(movie: movie, isNew: true)
                }
                // Prevent people from dragging the sheet down to dismiss it.
                .interactiveDismissDisabled()
                
            }
        } detail: {
            Text("Select a movie")
                .navigationTitle("Movies")
        }
    }

    private func addMovie() {
        withAnimation {
            let newItem = Movie(title: "testing movie", releaseDate: .now)
            modelContext.insert(newItem)
            newMovie = newItem
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(movies[index])
            }
        }
    }
}

#Preview {
        MovieList(enableToolbar: true)
            .modelContainer(SampleData.shared.modelContainer)
    
}

#Preview("Empty List") {
    
        MovieList(enableToolbar: true).modelContainer(for: Movie.self, inMemory: true)

    
}

#Preview("Filtered") {
    
        MovieList(titleFilter: "tr", enableToolbar: true)
            .modelContainer(SampleData.shared.modelContainer)

    
    
}
