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
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
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
        
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.fillSuperview()
    }
}

