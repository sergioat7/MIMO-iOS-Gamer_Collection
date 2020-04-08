//
//  UserProfileRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 16/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class UserProfileRouter: BaseRouter {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private var view:UserProfileViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "UserProfileView", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "UserProfile") as? UserProfileViewController {
            let viewModel: UserProfileViewModelProtocol = UserProfileViewModel(view: controller,
                                                                               dataManager: dataManager)
            controller.set(viewModel: viewModel)
            return controller
        }
        return UserProfileViewController()
    }
    
    private var dataManager: UserProfileDataManagerProtocol {
        return UserProfileDataManager(apiClient: apiClient,
                                      userManager: userManager,
                                      gameRepository: gameRepository,
                                      sagaRepository: sagaRepository)
    }
    
    private var apiClient: UserProfileApiClientProtocol {
        return UserProfileApiClient(userManager: userManager)
    }
    
    private var userManager: UserManager {
        return UserManager()
    }
    
    private var gameRepository: GameRepository {
        return GameRepository()
    }
    
    private var sagaRepository: SagaRepository {
        return SagaRepository()
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
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "profile"), tag: 0)
        navigationController.tabBarItem.selectedImage = UIImage(named: "profile on")
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        var viewControllers = tabBarController?.viewControllers ?? [UIViewController]()
        viewControllers.append(navigationController)
        tabBarController?.setViewControllers(viewControllers, animated: false)
    }
    
}

