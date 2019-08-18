//
//  HomeCoordinator.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 18/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators: [String : Coordinator]
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = [:]
        
        start()
    }
    
    func start() {
        let viewModel = HomeViewModel(apiService: APIService(), persistenceService: PersistenceService(), dataSource: HomeScreenDataSource())
        navigationController.pushViewController(HomeViewController(viewModel: viewModel), animated: false)
    }
}
