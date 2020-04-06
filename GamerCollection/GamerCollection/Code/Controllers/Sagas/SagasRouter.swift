//
//  SagasRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class SagasRouter: BaseRouter {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private var view:SagasViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "SagasView", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "Sagas") as? SagasViewController {
            let viewModel: SagasViewModelProtocol = SagasViewModel(view: controller,
                                                                   dataManager: dataManager)
            controller.set(viewModel: viewModel)
            return controller
        }
        return SagasViewController()
    }
    
    private var dataManager: SagasDataManagerProtocol {
        return SagasDataManager(apiClient: apiClient,
                                gameRepository: gameRepository,
                                sagaRepository: sagaRepository,
                                platformRepository: platformRepository,
                                stateRepository: stateRepository)
    }
    
    private var apiClient: SagasApiClientProtocol {
        return SagasApiClient()
    }
    
    private var gameRepository: GameRepository {
        return GameRepository()
    }
    
    private var sagaRepository: SagaRepository {
        return SagaRepository()
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
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "sagas"), tag: 0)
        navigationController.tabBarItem.selectedImage = UIImage(named: "sagas on")
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        var viewControllers = tabBarController?.viewControllers ?? [UIViewController]()
        viewControllers.append(navigationController)
        tabBarController?.setViewControllers(viewControllers, animated: false)
    }
    
}

