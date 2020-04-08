//
//  RegisterRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 15/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class RegisterRouter: BaseRouter {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private var view:RegisterViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "RegisterView", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "Register") as? RegisterViewController {
            let viewModel: RegisterViewModelProtocol = RegisterViewModel(view: controller,
                                                                         dataManager: dataManager)
            controller.set(viewModel: viewModel)
            return controller
        }
        return RegisterViewController()
    }
    
    private var dataManager: RegisterDataManagerProtocol {
        return RegisterDataManager(apiClient: apiClient,
                                   loginApiClient: loginApiClient,
                                   userManager: userManager,
                                   formatRepository: formatRepository,
                                   genreRepository: genreRepository,
                                   platformRepository: platformRepository,
                                   stateRepository: stateRepository)
    }
    
    private var apiClient: RegisterApiClientProtocol {
        return RegisterApiClient()
    }
    
    private var loginApiClient: LoginApiClientProtocol {
        return LoginApiClient(userManager: userManager)
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

    func push() {
        push(viewController: view)
    }
    
}

