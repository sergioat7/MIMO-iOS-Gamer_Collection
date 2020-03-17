//
//  AuthorizationHandler.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 13/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class AuthorizationHandler: RequestInterceptor {
    
    private let lock = NSLock()
    private var token: String
    

    // MARK: - Initialization

    public init(token: String) {
        self.token = token
    }
    
    // MARK: - RequestAdapter

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var mutableURLRequest = urlRequest
        mutableURLRequest.setValue(token, forHTTPHeaderField: "Authorization")
        completion(.success(mutableURLRequest))
    }
    
    // MARK: - RequestRetrier

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
    
    
    
}
