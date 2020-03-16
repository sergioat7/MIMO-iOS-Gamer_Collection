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
}

