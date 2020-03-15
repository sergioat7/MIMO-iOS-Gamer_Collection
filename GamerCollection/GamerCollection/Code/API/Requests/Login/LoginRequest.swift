//
//  LoginRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Alamofire

class LoginRequest: APIRequest {
    
    public typealias Response = LoginResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/users/login"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.post
    }
    
    public var resourcePath: String {
        return ""
    }
    
    public var body: Parameters? {
        return loginDataModelRequest.dictionary
    }
    
    public var adapter: RequestAdapter?
    
    private var loginDataModelRequest: LoginDataModelRequest
    
    public init(loginDataModelRequest: LoginDataModelRequest) {
        self.loginDataModelRequest = loginDataModelRequest
    }
}
