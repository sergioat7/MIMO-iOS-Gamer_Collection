//
//  SagasRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020. All rights reserved.
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
        return SagasDataManager(apiClient: apiClient)
    }
    
    private var apiClient: SagasApiClientProtocol {
        return SagasApiClient()
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
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "sagas"), tag: 0)//TODO set icons
        navigationController.tabBarItem.selectedImage = UIImage(named: "sagas on")
        
        var viewControllers = tabBarController?.viewControllers ?? [UIViewController]()
        viewControllers.append(navigationController)
        tabBarController?.setViewControllers(viewControllers, animated: false)
    }
    
}
