//
//  GetSagasRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 04/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class GetSagasRequest: APIRequest {
    
    public typealias Response = SagasResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/sagas"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.get
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
