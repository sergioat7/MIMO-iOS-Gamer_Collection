//
//  RegisterRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 15/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class RegisterRequest: APIRequest {
    
    public typealias Response = EmptyResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/users/register"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.post
    }
    
    public var resourcePath: String {
        return ""
    }
    
    public var body: Parameters? {
           return registerDataModelRequest.dictionary
       }
    
    public var adapter: RequestAdapter?
    
    private var registerDataModelRequest: RegisterDataModelRequest
    
    public init(registerDataModelRequest: RegisterDataModelRequest) {
        self.registerDataModelRequest = registerDataModelRequest
    }
}
