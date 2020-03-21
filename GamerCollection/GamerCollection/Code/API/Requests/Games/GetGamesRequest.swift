//
//  GetGamesRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 21/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class GetGamesRequest: APIRequest {
    
    public typealias Response = GamesResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/games"
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
