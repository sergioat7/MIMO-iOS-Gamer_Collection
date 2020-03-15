//
//  RegisterApiClient.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 15/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol RegisterApiClientProtocol {
    
    func register(username: String, password: String, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class RegisterApiClient: RegisterApiClientProtocol {
    
    func register(username: String, password: String, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let registerParameters = RegisterDataModelRequest(username: username,
                                                          password: password)
        let request = RegisterRequest(registerDataModelRequest: registerParameters)
        APIClient.shared.sendServer(request, success: success, failure: failure)
    }
    
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let loginParameters = LoginDataModelRequest(username: username,
                                                    password: password)
        let request = LoginRequest(loginDataModelRequest: loginParameters)
        APIClient.shared.sendServer(request, success: success, failure: failure)
    }
}
