//
//  LoginApiClient.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol LoginApiClientProtocol {
    
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class LoginApiClient: LoginApiClientProtocol {
    
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let loginParameters = LoginDataModelRequest(username: username,
                                                    password: password)
        let request = LoginRequest(loginDataModelRequest: loginParameters)
        APIClient.shared.sendServer(request, success: success, failure: failure)
    }
    
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let request = GetFormatsRequest()
        APIClient.shared.sendServer(request, success: success, failure: failure)
    }
}
