//
//  DeleteUserRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 16/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class DeleteUserRequest: APIRequest {
    
    public typealias Response = EmptyResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/users/user"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.delete
    }
    
    public var resourcePath: String {
        return ""
    }
    
    public var body: Parameters?
    
    public var interceptor: RequestInterceptor?
            
    public init(token: String) {
        let authorizationHandler = AuthorizationHandler(token: token)
        self.interceptor = authorizationHandler
    }
}
