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
        return GamesDataManager(apiClient: apiClient,
                                gameRepository: gameRepository,
                                platformRepository: platformRepository,
                                stateRepository: stateRepository)
    }
    
    private var apiClient: GamesApiClientProtocol {
        return GamesApiClient()
    }
    
    private var gameRepository: GameRepository {
        return GameRepository()
    }
    
    private var platformRepository: PlatformRepository {
        return PlatformRepository()
    }
    
    private var stateRepository: StateRepository {
        return StateRepository()
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
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        var viewControllers = tabBarController?.viewControllers ?? [UIViewController]()
        viewControllers.append(navigationController)
        tabBarController?.setViewControllers(viewControllers, animated: false)
    }
    
}

