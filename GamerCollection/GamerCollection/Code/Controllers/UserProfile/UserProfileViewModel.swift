//
//  UserProfileViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 16/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol UserProfileViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
    func viewDidLoad()
    func updatePassword(password: String)
    func deleteUser()
}

class UserProfileViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:UserProfileViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: UserProfileDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:UserProfileViewProtocol,
         dataManager: UserProfileDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
        super.init(view: view)
    }
    
    // MARK: - Private functions
    
    private func manageError(error: ErrorResponse) {

        view?.hideLoading()
        view?.showError(message: error.error, handler: nil)
    }
    
    private func logout() {
        
        dataManager.removeUserData()
        dataManager.removeCredentials()
        LoginRouter().show()
    }
}

extension UserProfileViewModel: UserProfileViewModelProtocol {
    
    func viewDidLoad() {
        
        showNavBarButtons()
        view?.showLoading()
        dataManager.getUserData(success: { userData in
            
            self.view?.seTextFields(username: userData.userName ?? "", password: userData.password ?? "")
            self.view?.hideLoading()
        }, failure: { error in
            self.manageError(error: error)
        })
    }
    
    func updatePassword(password: String) {
        
        view?.showLoading()
        dataManager.updatePassword(password: password, success: { _ in
            self.dataManager.storePassword(password: password)
            self.dataManager.getUserData(success: { userData in
                self.dataManager.login(username: userData.userName ?? "", password: userData.password ?? "", success: { loginResponse in
                    
                    let authData = AuthData(token: loginResponse.token)
                    self.dataManager.storeCredentials(authData: authData)
                    self.view?.hideLoading()
                }, failure: { error in
                    self.manageError(error: error)
                })
            }, failure: { error in
                self.manageError(error: error)
            })
        }, failure: { error in
            self.manageError(error: error)
        })
    }
    
    func deleteUser() {
        
        view?.showLoading()
        dataManager.deleteUser(success: { _ in
            
            self.logout()
            self.view?.hideLoading()
        }, failure: { error in
            self.manageError(error: error)
        })
    }
}

