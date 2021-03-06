//
//  DeleteGameRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 29/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class DeleteGameRequest: APIRequest {
    
    public typealias Response = EmptyResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/game"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.delete
    }
    
    public var resourcePath: String
    
    public var body: Parameters?
    
    public var interceptor: RequestInterceptor?
            
    public init(token: String,
                gameId: Int64) {
        let authorizationHandler = AuthorizationHandler(token: token)
        self.interceptor = authorizationHandler
        self.resourcePath = String(format: "/%ld", gameId)
    }
}
