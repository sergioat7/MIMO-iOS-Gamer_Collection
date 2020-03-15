//
//  RegisterViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 15/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol RegisterViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
    func register(username: String, password: String, repeatPassword: String)
}

class RegisterViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:RegisterViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: RegisterDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:RegisterViewProtocol,
         dataManager: RegisterDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    // MARK: - Private functions
    
    private func manageError(error: ErrorResponse) {

        view?.hideLoading()
        view?.showError(message: error.error, handler: nil)
    }
    
    private func syncApp() {
        
        //TODO get data from server
        MainTabBarController.show()
        view?.hideLoading()
    }
}

extension RegisterViewModel: RegisterViewModelProtocol {
    
    func register(username: String, password: String, repeatPassword: String) {
        
        guard password == repeatPassword else {
            let error = ErrorResponse(error: "ERROR_REGISTRATION_DIFFERENT_PASSWORDS".localized())
            manageError(error: error)
            return
        }
        
        view?.showLoading()
        dataManager.register(username: username, password: password, success: {
            self.dataManager.login(username: username, password: password, success: { loginResponse in

                let userData = UserData(userName: username, password: password, isLoggedIn: true)
                let authData = AuthData(token: loginResponse.token)
                self.dataManager.storeUserData(userData: userData)
                self.dataManager.storeCredentials(authData: authData)
                self.syncApp()
            }, failure: { error in
                self.manageError(error: error)
            })
        }, failure: { error in
            self.manageError(error: error)
        })
    }
}

