//
//  LoginDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol LoginDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
    func getUsername(success: @escaping (String?) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func storeUserData(userData: UserData)
    func storeCredentials(authData: AuthData)
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class LoginDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let apiClient: LoginApiClientProtocol
    private let userManager: UserManager
    private let formatRepository: FormatRepository
    
    // MARK: - Initialization
    
    init(apiClient: LoginApiClientProtocol,
         userManager: UserManager,
         formatRepository: FormatRepository) {
        self.apiClient = apiClient
        self.userManager = userManager
        self.formatRepository = formatRepository
    }
}

extension LoginDataManager: LoginDataManagerProtocol {
    
    func getUsername(success: @escaping (String?) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        userManager.getUserData(success: { userData in
            success(userData.userName)
        }, failure: failure)
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
    
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        apiClient.getFormats(success: { formats in
            
            for (index, format) in formats.enumerated() {
                self.formatRepository.update(item: format, success: { _ in
                    
                    if index == formats.count - 1 {
                        success(formats)
                    }
                }, failure: failure)
            }
        }, failure: failure)
    }
}

