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
    func loadMovies()
    
    /// Navigates to detail screen of selected movie
    ///
    /// - Parameters:
    ///   - navigationController: Navigation controller to push new viewcontroller in
    ///   - movie: The model object of selected movie
    func navigateToMovieDetails(in navigationController: UINavigationController, with movie: Movie)
    
    /// Callback in case of network error
    var didSendError: ((NetworkError) -> Void)? { get set }
}

final class HomeViewModel: HomeViewModelType {
    
    // MARK: - Dependencies
    
    private var apiService: APIServiceType!
    private var persistenceService: PersistenceServiceType!
    var dataSource: HomeScreenDataSource!
    
    // MARK: - Private properties
    
    private var currentPage: Int = 1
    var didSendError: ((NetworkError) -> Void)?
    
    // MARK: - Init
    
    init(dataSource: HomeScreenDataSource, apiService: APIServiceType!, persistenceService: PersistenceServiceType) {
        self.dataSource = dataSource
        self.apiService = apiService
        self.persistenceService = persistenceService
        
    }
    
    // MARK: - Private methods
    
    func loadMovies() {
        apiService.request(endpoint: .getTrendingMovies(page: String(currentPage))) { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let movieResponse):
                guard let movies = movieResponse["results"] as? [JSON] else { return }
                self.persistenceService.insertMoviesInCoreData(movies: movies, completion: {
                    self.persistenceService.fetch(Movie.self, completion: { [weak self] movies in
                        guard let self = self else { return }
                        self.dataSource.movies = movies
                        self.persistenceService.addImageDataToMovies()
                    })
                })
                
            case .failure(let error):
                switch error {
                case .decodeError, .invalidStatusCode:
                    print("Error: \(error.rawValue)")
                case .networkError:
                    self.persistenceService.fetch(Movie.self, completion: { [weak self] movies in
                        guard !movies.isEmpty else {
                            self?.didSendError?(error)
                            return
                        }
                        self?.dataSource.movies = movies
                    })
                }
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
