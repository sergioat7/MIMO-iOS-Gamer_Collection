//
//  UserProfileApiClient.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 16/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol UserProfileApiClientProtocol {
    
    func updatePassword(password: String, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class UserProfileApiClient: UserProfileApiClientProtocol {
    
    private let userManager: UserManager
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    func getCredentials(success: @escaping (AuthData) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        userManager.getCredentials(success: { authData in
            success(authData)
        }, failure: failure)
    }
    
    // MARK: - UserProfileApiClientProtocol
    
    func updatePassword(password: String, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getCredentials(success: { authData in
            
            let updatePasswordParameters = UpdatePasswordDataModelRequest(password: password)
            let request = UpdatePasswordRequest(token: authData.token, updatePasswordDataModelRequest: updatePasswordParameters)
            APIClient.shared.sendServer(request, success: success, failure: failure)
        }, failure: failure)
    }
        APIClient.shared.sendServer(request, success: success, failure: failure)
    }
}
