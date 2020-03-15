//
//  GamesRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class GamesRouter: BaseRouter {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private var view:GamesViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "GamesView", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "Games") as? GamesViewController {
            let viewModel: GamesViewModelProtocol = GamesViewModel(view: controller,
                                                                   dataManager: dataManager)
            controller.set(viewModel: viewModel)
            return controller
        }
        return GamesViewController()
    }
    
    private var dataManager: GamesDataManagerProtocol {
        return GamesDataManager(apiClient: apiClient)
    }
    
    private var apiClient: GamesApiClientProtocol {
        return GamesApiClient()
    }
    
    // MARK: - Initialization
    
    override init() {}
    
    // MARK: - Presentation Methods
    
    func push() {
        push(viewController: view)
    }
    
    func presentTabBar() {
        
        let tabBarController = UIViewController.getRootTabBarViewController()
        let viewController = view
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "games"), tag: 0)
        navigationController.tabBarItem.selectedImage = UIImage(named: "games on")
        
        var viewControllers = tabBarController?.viewControllers ?? [UIViewController]()
        viewControllers.append(navigationController)
        tabBarController?.setViewControllers(viewControllers, animated: false)
    }
    
}

