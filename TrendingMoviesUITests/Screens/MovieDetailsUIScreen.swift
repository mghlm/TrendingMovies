//
//  MovieDetailsUIScreen.swift
//  TrendingMoviesUITests
//
//  Created by Magnus Holm on 06/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import XCTest

enum MovieDetailsUIScreen {
    case movieDetailsView, posterImageView, movieDetailsTitleLabel, movieDetailsDescriptionLabel, releaseDateLabel, ratingLabel
    
    func component(in app: XCUIApplication) -> XCUIElement {
        switch self {
        case .movieDetailsView:
            return app.otherElements["movieDetailsViewIdentifier"]
        case .posterImageView:
            return app.images["posterImageViewIdentifier"]
        case .movieDetailsTitleLabel:
            return app.staticTexts["movieDetailsTitleLabelIdentifier"]
        case .movieDetailsDescriptionLabel:
            return app.staticTexts["movieDetailsDescriptionLabelIdentifier"]
        case .releaseDateLabel:
            return app.staticTexts["releaseDateLabelIdentifier"]
        case .ratingLabel:
            return app.staticTexts["ratingLabelIdentifier"]
        }
    }
    
    static func assertScreenExist(in app: XCUIApplication) {
        XCTAssert(MovieDetailsUIScreen.movieDetailsView.component(in: app).exists)
        XCTAssert(MovieDetailsUIScreen.posterImageView.component(in: app).exists)
        XCTAssert(MovieDetailsUIScreen.movieDetailsTitleLabel.component(in: app).exists)
        XCTAssert(MovieDetailsUIScreen.movieDetailsDescriptionLabel.component(in: app).exists)
        XCTAssert(MovieDetailsUIScreen.releaseDateLabel.component(in: app).exists)
        XCTAssert(MovieDetailsUIScreen.ratingLabel.component(in: app).exists)
    }
    
    static func assertScreenDoesNotExist(in app: XCUIApplication) {
        XCTAssertFalse(MovieDetailsUIScreen.movieDetailsView.component(in: app).exists)
    }
}

