//
//  HomeViewModelTests.swift
//  TrendingMoviesTests
//
//  Created by Magnus Holm on 06/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import XCTest
@testable import TrendingMovies

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModelType!
    var apiService: APIServiceMock!
    
    override func setUp() {
        apiService = APIServiceMock()
        viewModel = HomeViewModel(dataSource: HomeScreenDataSource(), apiService: apiService)
    }
    
    func testViewModel_DidLoadIsCalledAndResponseIsSuccess() {
        let expectation = self.expectation(description: "Movie")
        viewModel.didLoad { _ in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.dataSource.movies.count, 1)
        
        XCTAssertEqual(viewModel.dataSource.movies[0].id, 1)
        XCTAssertEqual(viewModel.dataSource.movies[0].originalLanguage, "English")
        XCTAssertEqual(viewModel.dataSource.movies[0].originalTitle, "Interstellar")
        XCTAssertEqual(viewModel.dataSource.movies[0].overview, "Space stuff")
        XCTAssertEqual(viewModel.dataSource.movies[0].popularity, 123456)
        XCTAssertEqual(viewModel.dataSource.movies[0].posterPath, "https://imgur.com/123.jpg")
        XCTAssertEqual(viewModel.dataSource.movies[0].releaseDate, "12-12-2009")
        XCTAssertEqual(viewModel.dataSource.movies[0].title, "Interstellar")
        XCTAssertEqual(viewModel.dataSource.movies[0].voteAverage, 8.2)
        XCTAssertEqual(viewModel.dataSource.movies[0].voteCount, 123456)
    }
    
    func testViewModel_DidLoadFailedWithApiError() {
        let expectation = self.expectation(description: "Movie")
        apiService.result = .apiError
        viewModel.didLoad { _ in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewModel.dataSource.movies.count, 0)
    }
}
