//
//  Item.swift
//  FriendsFavoritesMovies
//
//  Created by Tony Gultom on 13/08/24.
//

import Foundation
import SwiftData

@Model
final class Movie {
    var title: String
    var releaseDate: Date
    
    /*
     The [Friend]() syntax creates an empty array. To spell it out fully, you’d write
     var favoritedBy: [Friend] = []
     */
    var favoritedBy =  [Friend]()
    
    init(title: String, releaseDate: Date) {
        self.title = title
        self.releaseDate = releaseDate
    }
    
    
    
    static let sampleData = [
        Movie(title: "Amusing Space Traveler 3", releaseDate: Date(timeIntervalSinceReferenceDate: -402_000_000)),
        Movie(title: "Difficult Cat",

                      releaseDate: Date(timeIntervalSinceReferenceDate: -20_000_000)),

                Movie(title: "Electrifying Trek",

                      releaseDate: Date(timeIntervalSinceReferenceDate: 300_000_000)),

                Movie(title: "Reckless Train Ride 2",

                      releaseDate: Date(timeIntervalSinceReferenceDate: 120_000_000)),

                Movie(title: "The Last Venture",

                      releaseDate: Date(timeIntervalSinceReferenceDate: 550_000_000)),

                Movie(title: "Glamorous Neighbor",

                      releaseDate: Date(timeIntervalSinceReferenceDate: 700_000_000))
    ]
}
