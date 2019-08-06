//
//  APIServiceMock.swift
//  TrendingMoviesTests
//
//  Created by Magnus Holm on 06/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import XCTest
@testable import TrendingMovies

final class APIServiceMock: APIServiceType {
    
    enum ApiResults {
        case success, badStatusCode, decodeError, apiError
    }
    
    var result: ApiResults = .success
    
    var mockMovie = Movie(id: 1,
                          originalLanguage: "English",
                          originalTitle: "Interstellar",
                          overview: "Space stuff",
                          popularity: 123456,
                          posterPath: "https://imgur.com/123.jpg",
                          releaseDate: "12-12-2009",
                          title: "Interstellar",
                          voteAverage: 8.2,
                          voteCount: 123456)
    
    func request<T: Decodable>(_ type: T.Type, endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        switch result {
        case .success:
            let model = MovieResponse(results: [mockMovie]) as! T
            completion(.success(model))
        case .badStatusCode:
            completion(.failure(.invalidStatusCode))
        case .decodeError:
            completion(.failure(.decodeError))
        case .apiError:
            completion(.failure(.apiError))
        }
    }
}

