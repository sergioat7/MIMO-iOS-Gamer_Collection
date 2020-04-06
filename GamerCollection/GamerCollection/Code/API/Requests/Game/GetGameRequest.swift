//
//  GetGameRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 07/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class GetGameRequest: APIRequest {
    
    public typealias Response = GameResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/game"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.get
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
