//
//  UserProfileDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 16/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol UserProfileDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
    func getUserData(success: @escaping (UserData) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func updatePassword(password: String, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func storePassword(password: String)
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func storeCredentials(authData: AuthData)
    func deleteUser(success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func removeUserData()
    func removeCredentials()
}

class UserProfileDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    private let apiClient: UserProfileApiClientProtocol
    private let userManager: UserManager
    
    // MARK: - Private variables
    
    // MARK: - Initialization
    
    init(apiClient: UserProfileApiClientProtocol,
    userManager: UserManager) {
        self.apiClient = apiClient
        self.userManager = userManager
    }
}

extension UserProfileDataManager: UserProfileDataManagerProtocol {
    
    func getUserData(success: @escaping (UserData) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        userManager.getUserData(success: { userData in
            success(userData)
        }, failure: failure)
    }
    
    func updatePassword(password: String, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        apiClient.updatePassword(password: password, success: success, failure: failure)
    }
    
    func storePassword(password: String) {
        userManager.storePassword(pasword: password)
    }
    
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        apiClient.login(username: username, password: password, success: success, failure: failure)
    }
    
    func storeCredentials(authData: AuthData) {
        userManager.storeCredentials(authData: authData)
    }
        
    func deleteUser(success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        apiClient.deleteUser(success: success, failure: failure)
    }
    
    func removeUserData() {
        userManager.removeUserData()
    }
    
    func removeCredentials() {
        userManager.removeCredentials()
    }
}

