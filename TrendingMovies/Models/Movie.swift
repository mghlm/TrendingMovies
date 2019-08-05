//
//  Movie.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 05/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    var results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
    
    func getImageUrl() -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}


