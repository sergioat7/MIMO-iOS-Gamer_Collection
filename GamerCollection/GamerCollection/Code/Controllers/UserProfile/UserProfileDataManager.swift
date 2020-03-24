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
    func logout(success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func updatePassword(password: String, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func storePassword(password: String)
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func storeCredentials(authData: AuthData)
    func deleteUser(success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func removeUserData()
    func removePassword()
    func removeCredentials()
    func deleteGames(success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class UserProfileDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    private let apiClient: UserProfileApiClientProtocol
    private let userManager: UserManager
    private let gameRepository: GameRepository
    
    // MARK: - Private variables
    
    // MARK: - Initialization
    
    init(apiClient: UserProfileApiClientProtocol,
         userManager: UserManager,
         gameRepository: GameRepository) {
        self.apiClient = apiClient
        self.userManager = userManager
        self.gameRepository = gameRepository
    }
}

extension UserProfileDataManager: UserProfileDataManagerProtocol {
    
    func getUserData(success: @escaping (UserData) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        userManager.getUserData(success: { userData in
            success(userData)
        }, failure: failure)
    }
    
    func logout(success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        apiClient.logout(success: success, failure: failure)
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
    
    func removePassword() {
        userManager.removePassword()
    }
    
    func removeCredentials() {
        userManager.removeCredentials()
    }
    
    func deleteGames(success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        gameRepository.deleteAll(success: success, failure: failure)
    }
}

