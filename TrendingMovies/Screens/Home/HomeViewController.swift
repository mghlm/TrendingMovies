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
        viewModel.didLoad()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Trending movies"
        view.addSubview(tableView)
        tableView.delegate = viewModel.dataSource
        tableView.dataSource = viewModel.dataSource
        setupConstraints()
    }
    
    private func setupCallbacks() {
        viewModel.dataSource.didLoadData = { [weak self] in
            DispatchQueue.main.async {
                self?.setupUI()
                self?.tableView.reloadData()
            }
        }
        viewModel.dataSource.didUpdateData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupConstraints() {
        tableView.fillSuperview()
    }
}

