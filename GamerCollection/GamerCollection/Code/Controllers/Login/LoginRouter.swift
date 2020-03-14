//
//  LoginRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020. All rights reserved.
//

import UIKit

class LoginRouter: BaseRouter {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private var view:LoginViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "LoginView", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginViewController {
            let viewModel: LoginViewModelProtocol = LoginViewModel(view: controller,
                                                                   dataManager: dataManager)
            controller.set(viewModel: viewModel)
            return controller
        }
        return LoginViewController()
    }
    
    private var dataManager: LoginDataManagerProtocol {
        return LoginDataManager(apiClient: apiClient)
    }
    
    private var apiClient: LoginApiClientProtocol {
        return LoginApiClient()
    }
    
    // MARK: - Initialization
    
    override init() {}
    
    // MARK: - Presentation Methods
    
    func show() {
        let window = UIViewController.getCurrentWindow()
        let navigationController = UINavigationController(rootViewController: view)
        window?.rootViewController = navigationController
        window?.backgroundColor = .white
    }
    
    func push() {
        push(viewController: view)
    }
    
}

