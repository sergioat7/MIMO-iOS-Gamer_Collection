//
//  LoginViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol LoginViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
    func viewDidLoad()
    func login(username: String, password: String)
    func register()
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

extension LoginViewModel: LoginViewModelProtocol {
    
    func viewDidLoad() {
        
        view?.showLoading()
        dataManager.getUsername(success: { username in
            
            self.view?.setUsernameTextField(username: username ?? "")
            self.view?.hideLoading()
        }, failure: { error in
            self.view?.setUsernameTextField(username: "")
            self.view?.hideLoading()
        })
    }
    
    func login(username: String, password: String) {
        
        view?.showLoading()
        dataManager.login(username: username, password: password, success: { loginResponse in
            
            let userData = UserData(userName: username, password: password, isLoggedIn: true)
            let authData = AuthData(token: loginResponse.token)
            self.dataManager.storeUserData(userData: userData)
            self.dataManager.storeCredentials(authData: authData)
            self.syncApp()
        }, failure: { error in
            self.manageError(error: error)
        })
    }
    
    func register() {
        RegisterRouter().push()
    }
}

