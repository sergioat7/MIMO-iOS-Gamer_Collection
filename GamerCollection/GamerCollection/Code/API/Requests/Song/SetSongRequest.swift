//
//  SetSongRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 06/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class SetSongRequest: APIRequest {
    
    public typealias Response = SongResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/song"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.patch
    }
    
    public var resourcePath: String
    
    public var body: Parameters? {
        return song.dictionary
    }
    
    public var interceptor: RequestInterceptor?
    
    private var song: SongResponse
            
    public init(token: String,
                song: SongResponse) {
        let authorizationHandler = AuthorizationHandler(token: token)
        self.interceptor = authorizationHandler
        self.song = song
        self.resourcePath = String(format: "/%ld", song.id)
    }
}
