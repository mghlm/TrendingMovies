//
//  Movie+CoreDataProperties.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 07/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged var id: Int32
    @NSManaged var originalLanguage: String
    @NSManaged var originalTitle: String
    @NSManaged var overview: String
    @NSManaged var popularity: Double
    @NSManaged var posterPath: String?
    @NSManaged var releaseDate: String
    @NSManaged var title: String
    @NSManaged var voteAverage: Double
    @NSManaged var voteCount: Int32
    @NSManaged var image: Data?
    
    func getImageUrl() -> URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}
