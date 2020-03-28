//
//  UserProfileApiClient.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 16/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol UserProfileApiClientProtocol {
    
    func logout(success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func updatePassword(password: String, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func deleteUser(success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class UserProfileApiClient: UserProfileApiClientProtocol {
    
    // MARK: - Private variables
    
    private let userManager: UserManager
    
    // MARK: - Initialization
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    // MARK: - Private functions
    
    private func getCredentials(success: @escaping (AuthData) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        userManager.getCredentials(success: { authData in
            success(authData)
        }, failure: failure)
    }
    
    // MARK: - UserProfileApiClientProtocol
    
    func logout(success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getCredentials(success: { authData in
            
            let request = LogoutRequest(token: authData.token)
            APIClient.shared.sendServer(request, success: success, failure: failure)
        }, failure: failure)
    }
    
    func updatePassword(password: String, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getCredentials(success: { authData in
            
            let updatePasswordParameters = UpdatePasswordDataModelRequest(password: password)
            let request = UpdatePasswordRequest(token: authData.token, updatePasswordDataModelRequest: updatePasswordParameters)
            APIClient.shared.sendServer(request, success: success, failure: failure)
        }, failure: failure)
    }
    
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let loginParameters = LoginDataModelRequest(username: username,
                                                    password: password)
        let request = LoginRequest(loginDataModelRequest: loginParameters)
        APIClient.shared.sendServer(request, success: success, failure: failure)
    }
    
    func deleteUser(success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getCredentials(success: { authData in
            
            let request = DeleteUserRequest(token: authData.token)
            APIClient.shared.sendServer(request, success: success, failure: failure)
        }, failure: failure)
    }
}
