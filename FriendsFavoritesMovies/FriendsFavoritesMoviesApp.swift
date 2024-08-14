//
//  FriendsFavoritesMoviesApp.swift
//  FriendsFavoritesMovies
//
//  Created by Tony Gultom on 13/08/24.
//

import SwiftUI
import SwiftData

@main
struct FriendsFavoritesMoviesApp: App {
    var sharedModelContainer: ModelContainer = {
      /*
       The schema of a model helps connect the classes you define in your code to the data in the data store.
       */
        
        let schema = Schema([
            Movie.self,
            Friend.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
