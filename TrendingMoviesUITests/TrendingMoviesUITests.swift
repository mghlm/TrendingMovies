//
//  TrendingMoviesUITests.swift
//  TrendingMoviesUITests
//
//  Created by Magnus Holm on 05/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import XCTest

class TrendingMoviesUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testGoToMovieDetailsFlow() {
        
        // Assert Home Screen
        HomeUIScreen.assertScreenExist(in: app)
        
        // Navigate to details
        HomeUIScreen.tableView.component(in: app).cells.element(boundBy: 1).tap()
        
        // Assert details screen
        MovieDetailsUIScreen.assertScreenExist(in: app)
    }
}
