//
//  MovieDetailsViewModel.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 05/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

protocol MovieDetailsViewModelType {
    var movie: Movie! { get }
}

final class MovieDetailsViewModel: MovieDetailsViewModelType {
    
    // MARK: - Private properties
    
    var movie: Movie!
    
    init(movie: Movie) {
        self.movie = movie
    }
}
