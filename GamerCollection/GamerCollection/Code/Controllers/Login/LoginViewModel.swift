//
//  LoginViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020. All rights reserved.
//

import UIKit

protocol LoginViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
}

class LoginViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:LoginViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: LoginDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:LoginViewProtocol,
         dataManager: LoginDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    
}

