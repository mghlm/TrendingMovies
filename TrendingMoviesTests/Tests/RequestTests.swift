//
//  RequestTests.swift
//  TrendingMoviesTests
//
//  Created by Magnus Holm on 10/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import XCTest
@testable import TrendingMovies

class RequestTests: XCTestCase {
    
    var apiService: APIServiceType! 

    override func setUp() {
        apiService = APIService()
    }
    
    func testCorrectRequestUrlIsCreated() {
        let endpoint: Endpoint = .getTrendingMovies(page: "1")
        let urlRequest = apiService.buildRequest(for: endpoint)
        
        XCTAssertEqual(urlRequest!.url!, URL(string:("https://api.themoviedb.org/3/trending/movie/day?api_key=8e81b6228c55e10e7fbd202f92e7f19c&page=1&region=gb")))
        XCTAssertEqual(urlRequest?.httpMethod, "GET")
    }

}
