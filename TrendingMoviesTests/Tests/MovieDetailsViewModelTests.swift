//
//  MovieDetailsViewModelTests.swift
//  TrendingMoviesTests
//
//  Created by Magnus Holm on 10/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import XCTest
@testable import TrendingMovies

class MovieDetailsViewModelTests: XCTestCase {
    
    var viewModel: MovieDetailsViewModelType!

    override func setUp() {
        viewModel = MovieDetailsViewModel(movie: Movie())
    }
    
    func testMovieIsSetup() {
        XCTAssertNotNil(viewModel.movie)
    }
}
