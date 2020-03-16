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
    
    func updatePassword(password: String, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let updatePasswordParameters = UpdatePasswordDataModelRequest(password: password)
        let request = UpdatePasswordRequest(updatePasswordDataModelRequest: updatePasswordParameters)
        APIClient.shared.sendServer(request, success: success, failure: failure)
    }
}
