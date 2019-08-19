//
//  HomeCoordinator.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 18/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

protocol HomeCoordinatorType: Coordinator {
    func navigateToMovieDetails(with movie: Movie)
}

final class HomeCoordinator: HomeCoordinatorType {
    
    // MARK: - Public properties
    
    var childCoordinators: [String : Coordinator]
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = [:]
        
        start()
    }
    
    // MARK: - Public methods 
    
    func start() {
        let viewModel = HomeViewModel(apiService: APIService(), persistenceService: PersistenceService(), dataSource: HomeScreenDataSource(), coordinator: self)
        let homeViewController = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(homeViewController, animated: false)
    }
    
    func navigateToMovieDetails(with movie: Movie) {
        let movieDetailsViewModel = MovieDetailsViewModel(movie: movie)
        let movieDetailsViewController = MovieDetailsViewController(viewModel: movieDetailsViewModel)
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}
