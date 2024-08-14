//
//  SampleData.swift
//  FriendsFavoritesMovies
//
//  Created by Tony Gultom on 13/08/24.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    
    
    /*
     Singleton Pattern: Only one instance of SampleData is used throughout the app.
     */
    static let shared = SampleData()
    /*
     This model container will store its data in memory without persisting it.
     */
    
    
    let modelContainer: ModelContainer
    
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    private init() {
        let schema = Schema([
                 Movie.self,
                 Friend.self
             ])
        /*
         
         model configuration to store its data in memory only, without persisting it to disk.
         */

             let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
             

             do {

                 /*
                  
                  The code tries to create the modelContainer.
                  If it fails (for example, due to a bug), it will print an error message and stop the app
                  */
                 modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
                 
                 
                 insertSampleData()

             } catch {

                 fatalError("Could not create ModelContainer: \(error)")

             }
    }
    
    func insertSampleData() {
        for movie in Movie.sampleData {
            context.insert(movie)
        }
        
        for friend in Friend.sampleData {
            context.insert(friend)
        }
        
        
            Friend.sampleData[0].favoriteMovie = Movie.sampleData[1]

            Friend.sampleData[2].favoriteMovie = Movie.sampleData[0]

            Friend.sampleData[3].favoriteMovie = Movie.sampleData[4]

            Friend.sampleData[4].favoriteMovie = Movie.sampleData[0]
        
        
        
        
        
            /*
             Inside the do clause, you can call as many throwing functions as you want.
             Then, inside the catch clause, write the code that deals with any errors that were thrown.
             If all the throwing functions succeed, the catch block isn’t executed.
             */
        
        do {

                   try context.save()

               } catch {
                   print("Sample data context failed to save.")
                   

               }
    }
    
    var movie: Movie {
        Movie.sampleData[0]
    }
    
    var friend: Friend {
        Friend.sampleData[0]
    }
    
}
