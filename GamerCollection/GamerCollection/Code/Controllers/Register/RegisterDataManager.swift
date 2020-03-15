//
//  RegisterDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 15/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol RegisterDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
    func register(username: String, password: String, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void)
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func storeUserData(userData: UserData)
    func storeCredentials(authData: AuthData)
}

class RegisterDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let apiClient: RegisterApiClientProtocol
    private let userManager: UserManager
    
    // MARK: - Initialization
    
    init(apiClient: RegisterApiClientProtocol,
         userManager: UserManager) {
        self.apiClient = apiClient
        self.userManager = userManager
    }
}

extension RegisterDataManager: RegisterDataManagerProtocol {
    
    func register(username: String, password: String, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        apiClient.register(username: username, password: password, success: {_ in success()}, failure: failure)
    }
    
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        apiClient.login(username: username, password: password, success: success, failure: failure)
    }
    
    func storeUserData(userData: UserData) {
        userManager.storeUserData(userData: userData)
    }
    
    func storeCredentials(authData: AuthData) {
        userManager.storeCredentials(authData: authData)
    }
}

