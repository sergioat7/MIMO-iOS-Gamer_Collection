//
//  CreateSongRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 06/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class CreateSongRequest: APIRequest {
    
    public typealias Response = EmptyResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/songs"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.post
    }
    
    public var resourcePath: String
    
    public var body: Parameters? {
        return song.dictionary
    }
    
    public var interceptor: RequestInterceptor?
    
    private var song: SongResponse
            
    public init(token: String,
                gameId: Int64,
                song: SongResponse) {
        let authorizationHandler = AuthorizationHandler(token: token)
        self.interceptor = authorizationHandler
        self.resourcePath = String(format: "/%ld", gameId)
        self.song = song
    }
}
