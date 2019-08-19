//
//  HomeCoordinatorMock.swift
//  TrendingMoviesTests
//
//  Created by Magnus Holm on 19/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit
@testable import TrendingMovies

final class HomeCoordinatorMock: HomeCoordinatorType {
    
    var childCoordinators: [String : Coordinator] = [:]
    var navigationController: UINavigationController
    
    var startCallCount = 0
    var navigateToMoviesCount = 0
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startCallCount += 1
    }
    
    func navigateToMovieDetails(with movie: Movie) {
        navigateToMoviesCount += 1
    }
}
