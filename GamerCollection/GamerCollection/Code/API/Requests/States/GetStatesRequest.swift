//
//  GetStatesRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 20/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class GetStatesRequest: APIRequest {
    
    public typealias Response = StatesResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/states"
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
