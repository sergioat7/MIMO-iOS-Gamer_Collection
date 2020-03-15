//
//  UserProfileRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
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
        return UserProfileDataManager()
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
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "profile"), tag: 0)//TODO set icons
        navigationController.tabBarItem.selectedImage = UIImage(named: "profile on")
        
        var viewControllers = tabBarController?.viewControllers ?? [UIViewController]()
        viewControllers.append(navigationController)
        tabBarController?.setViewControllers(viewControllers, animated: false)
    }
    
}

