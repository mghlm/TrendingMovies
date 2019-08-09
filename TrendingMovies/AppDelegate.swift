//
//  AppDelegate.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 05/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        PersistenceService.applicationDocumentsDirectory()
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        let viewModel = HomeViewModel(dataSource: HomeScreenDataSource(), apiService: APIService(), persistenceService: PersistenceService())
        window?.rootViewController = UINavigationController(rootViewController: HomeViewController(viewModel: viewModel))
        
        return true
    }
}
