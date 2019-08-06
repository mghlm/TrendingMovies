//
//  HomeViewModel.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 05/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

protocol HomeViewModelType {
    
    /// Data source responsible for implementing tableview delegate- and datasource methods and keeping state
    var dataSource: HomeScreenDataSource! { get }
    
    /// Method to fetch initial data
    func didLoad(completion: @escaping (Result<Void, NetworkError>) -> Void)
    
    /// Navigates to detail screen of selected movie
    ///
    /// - Parameters:
    ///   - navigationController: Navigation controller to push new viewcontroller in
    ///   - movie: The model object of selected movie
    func navigateToMovieDetails(in navigationController: UINavigationController, with movie: Movie)
}

final class HomeViewModel: HomeViewModelType {
    
    // MARK: - Dependencies
    
    private var apiService: APIServiceType!
    var dataSource: HomeScreenDataSource!
    
    // MARK: - Init
    
    init(dataSource: HomeScreenDataSource, apiService: APIServiceType!) {
        self.dataSource = dataSource
        self.apiService = apiService
    }
    
    // MARK: - Private methods
    
    func didLoad(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        apiService.request(MovieResponse.self, endpoint: .getTrendingMovies) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieResponse):
                self.dataSource.movies = movieResponse.results
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Extensions 

extension HomeViewModel {
    func navigateToMovieDetails(in navigationController: UINavigationController, with movie: Movie) {
        let movieDetailsViewModel = MovieDetailsViewModel(movie: movie)
        let movieDetailsViewController = MovieDetailsViewController(viewModel: movieDetailsViewModel)
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}
