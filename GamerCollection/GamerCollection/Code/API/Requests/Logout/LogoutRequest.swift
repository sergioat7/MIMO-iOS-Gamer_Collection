//
//  LogoutRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 21/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class LogoutRequest: APIRequest {
    
    public typealias Response = EmptyResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/users/logout"
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
