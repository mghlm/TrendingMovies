//
//  HomeViewModel.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 05/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

protocol HomeViewModelType {
    var dataSource: HomeScreenDataSource! { get }
    func didLoad()
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
    
    func didLoad() {
        apiService.request(MovieResponse.self, endpoint: .getTrendingMovies) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieResponse):
                self.dataSource.movies = movieResponse.results
                self.dataSource.didLoadData?()
                print(movieResponse.results)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}
