//
//  HomeViewController.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 05/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private var viewModel: HomeViewModelType!
    
    // MARK: - Private properties
    
    lazy private var tableView: UITableView = {
        let tv = UITableView()
        tv.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: HomeScreenTableViewCell.id)
        tv.accessibilityIdentifier = "homeScreenTableViewIdentifier"
        
        return tv
    }()
    
    // MARK: - Init
    
    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCallbacks()
        loadMovies()
    }
    
    // MARK: - Private methods
    
    private func loadMovies() {
        self.viewModel.loadMovies()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Trending movies"
        view.addSubview(tableView)
        tableView.delegate = viewModel.dataSource
        tableView.dataSource = viewModel.dataSource
        tableView.fillSuperview()
        tableView.reloadData()
    }
    
    private func setupCallbacks() {
        viewModel.dataSource.didLoadData = { [weak self] in
            DispatchQueue.main.async {
                self?.setupUI()
            }
        }
        viewModel.dataSource.didTapCell = { [weak self] movie in
            guard let navController = self?.navigationController else { return }
            DispatchQueue.main.async {
                self?.viewModel.navigateToMovieDetails(in: navController, with: movie)
            }
        }
        viewModel.didSendError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showAlert(with: "Error", message: error.rawValue, delay: 5)
            }
        }
    }
    
    private func showAlert(with title: String, message: String?, delay: Double) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true)
        
        let deadline = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

