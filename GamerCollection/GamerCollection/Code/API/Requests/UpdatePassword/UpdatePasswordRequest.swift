//
//  UpdatePasswordRequest.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 16/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class UpdatePasswordRequest: APIRequest {
    
    public typealias Response = EmptyResponse
    
    public typealias Error = ErrorResponse
        
    public var resourceName: String {
        return "/users/updatePassword"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.put
    }
    
    public var resourcePath: String {
        return ""
    }
    
    public var body: Parameters? {
        return updatePasswordDataModelRequest.dictionary
    }
    
    public var adapter: RequestAdapter?
    
    private var updatePasswordDataModelRequest: UpdatePasswordDataModelRequest
            
    public init(updatePasswordDataModelRequest: UpdatePasswordDataModelRequest) {
        self.updatePasswordDataModelRequest = updatePasswordDataModelRequest
    }
}
