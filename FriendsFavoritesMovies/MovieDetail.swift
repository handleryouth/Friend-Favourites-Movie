//
//  MovieDetail.swift
//  FriendsFavoritesMovies
//
//  Created by Tony Gultom on 13/08/24.
//

import SwiftUI

struct MovieDetail: View {
    /*
     The @Bindable annotation silently creates a $movie
     property, just as @State does with view state properties.
     */
    @Bindable var movie: Movie
    
    let isNew: Bool
    
    /*
     @Environment property to access important global information,
     like the current color scheme of the display.
     */
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    
    var sortedFriends: [Friend] {
        /*
         you return true if the first item comes before the second and false otherwise.
         */
        movie.favoritedBy.sorted{
            first, second in first.name < second.name
        }
    }
    
    
    init(movie: Movie, isNew: Bool) {
        self.movie = movie
        self.isNew = isNew
    }
   
    var body: some View {
        Form {
            Text(movie.title)
            
            DatePicker("Release date", selection: $movie.releaseDate, displayedComponents: .date)
            
            
            
            if(!movie.favoritedBy.isEmpty) {
                Section("Favorited by") {

                             ForEach(sortedFriends) { friend in

                                 Text(friend.name)

                             }

                         }
            }
            
        }.navigationTitle(isNew ? "New Movie" : "Movie Detail").toolbar{
            if(isNew) {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Cancel") {
                        modelContext.delete(movie)
                        dismiss()
                    }
                }
            }
           
        }
        
    }
}

#Preview("New Movie") {
    NavigationStack {
    MovieDetail(movie: SampleData.shared.movie, isNew: true).modelContainer(SampleData.shared.modelContainer)
    }.navigationBarTitleDisplayMode(.inline)
    
}
