//
//  HomeUIScreen.swift
//  TrendingMoviesUITests
//
//  Created by Magnus Holm on 06/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import XCTest

enum HomeUIScreen {
    case tableView
    
    func component(in app: XCUIApplication) -> XCUIElement {
        switch self {
        case .tableView:
            return app.tables["homeScreenTableViewIdentifier"]
        }
    }
    
    static func assertScreenExist(in app: XCUIApplication) {
        XCTAssert(HomeUIScreen.tableView.component(in: app).exists)
    }
    
    static func assertScreenDoesNotExist(in app: XCUIApplication) {
        XCTAssertFalse(HomeUIScreen.tableView.component(in: app).exists)
    }
}

