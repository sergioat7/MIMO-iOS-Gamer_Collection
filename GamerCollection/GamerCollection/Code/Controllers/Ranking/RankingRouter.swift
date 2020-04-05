//
//  RankingRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class RankingRouter: BaseRouter {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private var view:RankingViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "RankingView", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "Ranking") as? RankingViewController {
            let viewModel: RankingViewModelProtocol = RankingViewModel(view: controller,
                                                                       dataManager: dataManager)
            controller.set(viewModel: viewModel)
            return controller
        }
        return RankingViewController()
    }
    
    private var dataManager: RankingDataManagerProtocol {
        return RankingDataManager(gameRepository: gameRepository,
                                  platformRepository: platformRepository,
                                  stateRepository: stateRepository)
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
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ranking"), tag: 0)//TODO set icons
        navigationController.tabBarItem.selectedImage = UIImage(named: "ranking on")
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        var viewControllers = tabBarController?.viewControllers ?? [UIViewController]()
        viewControllers.append(navigationController)
        tabBarController?.setViewControllers(viewControllers, animated: false)
    }
    
}

