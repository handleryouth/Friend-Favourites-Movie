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
        let schema = Schema([
            Item.self,
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
