//
//  MovieDetailsViewController.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 05/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private var viewModel: MovieDetailsViewModelType!
    
    // MARK: - Private propreties
    
    private var movieDetailsView: MovieDetailsView!
    
    lazy private var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        
        return sv
    }()
    
    lazy private var contentView: UIView = {
        let v = UIView()

        return v
    }()
    
    // MARK: - Init
    
    init(viewModel: MovieDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupMovieDetailsView() {
        contentView.addSubview(scrollView)
        movieDetailsView = MovieDetailsView(frame: .zero, movie: viewModel.movie)
        movieDetailsView.accessibilityIdentifier = "movieDetailsViewIdentifier"
        scrollView.addSubview(movieDetailsView)
        scrollView.fillSuperview()
        movieDetailsView.fillSuperview()
        movieDetailsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = viewModel.movie.title
        view.addSubview(contentView)
        setupConstraints()
        setupMovieDetailsView()
    }
    
    private func setupConstraints() {
        contentView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
