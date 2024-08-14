//
//  FilteredMovieList.swift
//  FriendsFavoritesMovies
//
//  Created by Tony Gultom on 14/08/24.
//

import SwiftUI

struct FilteredMovieList: View {
    
    @State private var searchText = ""
    
    
    var body: some View {
        NavigationSplitView {
            MovieList(titleFilter: searchText).searchable(text: $searchText)
        } detail: {
            Text("Select a movie").navigationTitle("Movie")
        }
        
    }
}

#Preview {
    FilteredMovieList().modelContainer(SampleData.shared.modelContainer)
}
