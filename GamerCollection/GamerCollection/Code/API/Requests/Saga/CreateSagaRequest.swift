//
//  CreateSagaRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class CreateSagaRequest: APIRequest {
    
    public typealias Response = EmptyResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/saga"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.post
    }
    
    public var resourcePath: String {
        return ""
    }
    
    public var body: Parameters? {
        return saga.dictionary
    }
    
    public var interceptor: RequestInterceptor?
           
    private var saga: SagaResponse
            
    public init(token: String,
                saga: SagaResponse) {
        let authorizationHandler = AuthorizationHandler(token: token)
        self.interceptor = authorizationHandler
        self.saga = saga
    }
}
