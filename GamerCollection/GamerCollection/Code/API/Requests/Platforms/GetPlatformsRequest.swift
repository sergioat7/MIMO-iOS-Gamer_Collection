//
//  GetPlatformsRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 20/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class GetPlatformsRequest: APIRequest {
    
    public typealias Response = PlatformsResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/platforms"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    public var resourcePath: String {
        return ""
    }
    
    public var body: Parameters?
    
    public var interceptor: RequestInterceptor?
            
    public init() {}
}
