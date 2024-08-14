//
//  FriendDetail.swift
//  FriendsFavoritesMovies
//
//  Created by Tony Gultom on 13/08/24.
//

import SwiftUI
import SwiftData

struct FriendDetail: View {
    
    @Bindable var friend: Friend
    
    @Query(sort: \Movie.title) private var movies: [Movie]
    
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    
    
    init(friend: Friend, isNew: Bool) {
        self.friend = friend
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $friend.name).autocorrectionDisabled()
            
            
            
            /*
             the value of the tag is assigned to the selection binding, which in this case is $friend.favoriteMovie.
             
             
             When a user selects a movie from the picker, the tag value of the selected Text view is assigned to $friend.favoriteMovie.
             */
            Picker("Favorite Movie", selection: $friend.favoriteMovie){
                /*
                 To enable a friend to have no favorite movie, add another choice to the picker.
                 */
                Text("None").tag(nil as Movie?)
                
                ForEach(movies) {
                    movie in Text(movie.title).tag(movie as  Movie?)
                }
                
                
                
            }
            
            
            
            
        }.navigationTitle(isNew ? "New Friend" : "Friend").toolbar{
            if(isNew) {
                ToolbarItem(placement: .confirmationAction){
                    Button("Done") {
                        if(!friend.name.isEmpty) {
                            dismiss()
                        }
                        
                    }
                }
                
                ToolbarItem(placement: .confirmationAction){
                    Button("Cancel") {
                        modelContext.delete(friend)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FriendDetail(friend: SampleData.shared.friend, isNew: true)
            .toolbarTitleDisplayMode(.inline)
            
    }.modelContainer(SampleData.shared.modelContainer)
    
}
