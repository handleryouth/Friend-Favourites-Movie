//
//  ContentView.swift
//  FriendsFavoritesMovies
//
//  Created by Tony Gultom on 13/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            
            FilteredMovieList().tabItem { Label("Search Movies", systemImage: "magnifyingglass") }
            
            MovieList(enableToolbar: true).tabItem { Label("Movies", systemImage: "film.stack") }
            
            
            FriendList().tabItem { Label("Friends", systemImage: "person.and.person") }
        }
    }
}

#Preview {
    ContentView().modelContainer(SampleData.shared.modelContainer)
}
