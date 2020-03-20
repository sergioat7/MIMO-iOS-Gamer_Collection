//
//  LoginRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
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
        return LoginDataManager(apiClient: apiClient,
                                userManager: userManager,
                                formatRepository: formatRepository,
                                genreRepository: genreRepository,
                                platformRepository: platformRepository,
                                stateRepository: stateRepository)
    }
    
    private var apiClient: LoginApiClientProtocol {
        return LoginApiClient()
    }
    
    private var userManager: UserManager {
        return UserManager()
    }
    
    private var formatRepository: FormatRepository {
        return FormatRepository()
    }
    
    private var genreRepository: GenreRepository {
        return GenreRepository()
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

