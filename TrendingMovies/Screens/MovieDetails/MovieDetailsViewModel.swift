//
//  MovieDetailsViewModel.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 05/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

protocol MovieDetailsViewModelType {
    
    /// Movie object to show in details screen
    var movie: Movie! { get }
}

final class MovieDetailsViewModel: MovieDetailsViewModelType {
    
    // MARK: - Private properties
    
    var movie: Movie!
    
    // MARK: - Init
    
    init(movie: Movie) {
        self.movie = movie
    }
}
