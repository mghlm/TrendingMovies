//
//  HomeScreenDataSource.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 05/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class HomeScreenDataSource: NSObject {
    
    // MARK: - Public properties
    
    var movies: [Movie]? {
        didSet {
            didLoadData?()
        }
    }
    var didLoadData: (() -> Void)?
    var didTapCell: ((Movie) -> ())?
}

// MARK: - Extensions

extension HomeScreenDataSource: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movies = movies else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenTableViewCell.id, for: indexPath) as! HomeScreenTableViewCell
        let movie = movies[indexPath.row]
        cell.movie = movie
        return cell 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movies = movies else { return }
        let movie = movies[indexPath.row]
        didTapCell?(movie)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
