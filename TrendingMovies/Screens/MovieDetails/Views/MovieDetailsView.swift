//
//  MovieDetailsView.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 06/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class MovieDetailsView: UIView {
    
    // MARK: - Dependencies
    
    private var movie: Movie!
    
    // MARK: - Private properties
    
//    lazy private var stackView: UIStackView!
    
    lazy private var posterImageView: ImageLoader = {
        let iv = ImageLoader()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    lazy private var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 28)
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    lazy private var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.italicSystemFont(ofSize: 22)
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    lazy private var releaseDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.italicSystemFont(ofSize: 18)
        lbl.textColor = .gray
        
        return lbl
    }()
    
    lazy private var ratingLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        
        return lbl
    }()
    
    // MARK: - Init
    
    init(frame: CGRect, movie: Movie) {
        self.movie = movie
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        setupImage()
        [posterImageView, titleLabel, descriptionLabel, releaseDateLabel, ratingLabel].forEach { addSubview($0) }
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
        releaseDateLabel.text = "Released \(movie.releaseDate)"
        ratingLabel.text = "⭐️ \(movie.voteAverage)"
        setupConstraints()
    }
    
    private func setupImage() {
        if let imageURL = movie.getImageUrl() {
            posterImageView.loadImage(with: imageURL)
        }
    }
    
    private func setupConstraints() {
        posterImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: UIScreen.main.bounds.width * 1.5)
        titleLabel.anchor(top: posterImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        releaseDateLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        descriptionLabel.anchor(top: releaseDateLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 18, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        ratingLabel.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 0, width: 0, height: 0)
    }
}
