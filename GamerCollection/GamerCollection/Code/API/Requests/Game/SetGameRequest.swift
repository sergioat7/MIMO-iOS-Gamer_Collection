//
//  SetGameRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 28/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class SetGameRequest: APIRequest {
    
    public typealias Response = GameResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/game"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.patch
    }
    
    public var resourcePath: String
    
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
        self.resourcePath = String(format: "/%ld", game.id)
    }
}
