//
//  HomeScreenTableViewCell.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 05/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class HomeScreenTableViewCell: UITableViewCell {
    
    static var id = "HomeScreenTableViewCellIdentifier"
    
    // MARK: - Public properties
    
    var movie: Movie! {
        didSet {
            setupUI()
        }
    }
    
    // MARK: - Private properties
    
    lazy private var posterImageView: ImageLoader = {
        let iv = ImageLoader()
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        
        return iv
    }()
    
    lazy private var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        
        return lbl
    }()
    
    // MARK: - Private methods
    
    private func setupUI() {
        [posterImageView, titleLabel].forEach { addSubview($0) }
        setupImage()
        titleLabel.text = movie.title
        
        setupConstraints()
    }
    
    private func setupImage() {
        
        if let imageData = movie.image, let image = UIImage(data: imageData) {
            posterImageView.image = image
        } else if let imageURL = movie.getImageUrl() {
            posterImageView.loadImage(with: imageURL)
        }
    }
    
    private func setupConstraints() {
        posterImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 66, height: 76)
        titleLabel.anchor(top: topAnchor, left: posterImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
    }
    
}
