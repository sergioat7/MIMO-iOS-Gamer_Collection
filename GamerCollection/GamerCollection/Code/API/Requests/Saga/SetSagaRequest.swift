//
//  SetSagaRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class SetSagaRequest: APIRequest {
    
    public typealias Response = SagaResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/saga"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.patch
    }
    
    public var resourcePath: String
    
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
        self.resourcePath = String(format: "/%ld", saga.id)
    }
}
