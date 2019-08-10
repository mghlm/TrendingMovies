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
        case success, badStatusCode, decodeError, networkError
    }
    
    var result: ApiResults = .success

    var mockMovie: JSON = ["id" : 123,
                           "original_language" : "en",
                           "original_title" : "Interstellar",
                           "overview" : "Space stuff",
                           "popularity" : 999.999,
                           "poster_path" : "https://imgur.com/123.jpg",
                           "release_date" : "21.12.2009",
                           "title" : "Interstellar",
                           "vote_average" : 9.9,
                           "vote_count" : 123
    ]
    
    func request(endpoint: Endpoint, completion: @escaping (Result<JSON, NetworkError>) -> Void) {
        switch result {
        case .success:
            let movieResponseMock = ["results": [mockMovie]] as JSON
            completion(.success(movieResponseMock))
        case .badStatusCode:
            completion(.failure(.invalidStatusCode))
        case .decodeError:
            completion(.failure(.decodeError))
        case .networkError:
            completion(.failure(.networkError))
        }
    }
    
    func buildRequest(for endpoint: Endpoint) -> URLRequest? { return nil }
}

