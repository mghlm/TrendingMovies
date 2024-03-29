//
//  Endpoint .swift
//  TrendingMovies
//
//  Created by Magnus Holm on 05/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

enum Endpoint {
    
    case getTrendingMovies(page: String)
    
    var scheme: String {
        switch self {
        case .getTrendingMovies:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getTrendingMovies:
            return "api.themoviedb.org"
        }
    }
    
    var path: String {
        switch self {
        case .getTrendingMovies:
            return "/3/trending/movie/day"
        }
    }
    
    var method: String {
        switch self {
        case .getTrendingMovies:
            return "GET"
        }
    }
    
    var parameters: [URLQueryItem] {
        let apiKey = "8e81b6228c55e10e7fbd202f92e7f19c"
        switch self {
        case .getTrendingMovies(let page):
            return [URLQueryItem(name: "api_key", value: apiKey),
                    URLQueryItem(name: "page", value: page),
                    URLQueryItem(name: "region", value: "gb")
            ]
        }
    }
}

