//
//  CreateGameRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 29/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class CreateGameRequest: APIRequest {
    
    public typealias Response = EmptyResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/game"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.post
    }
    
    public var resourcePath: String {
        return ""
    }
    
    public var body: Parameters? {
        return game.dictionary
    }
    
    public var interceptor: RequestInterceptor?
    
    private var game: GameResponse
            
    public init(token: String,
                game: GameResponse) {
        let authorizationHandler = AuthorizationHandler(token: token)
        self.interceptor = authorizationHandler
        self.game = game
    }
}
