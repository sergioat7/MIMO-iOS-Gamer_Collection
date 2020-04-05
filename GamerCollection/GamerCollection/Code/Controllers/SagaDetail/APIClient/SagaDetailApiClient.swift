//
//  SagaDetailApiClient.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol SagaDetailApiClientProtocol {
    
    func setSaga(saga: SagaResponse, success: @escaping (SagaResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func createSaga(saga: SagaResponse, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class SagaDetailApiClient: SagaDetailApiClientProtocol {
    
    // MARK: - Private variables
    
    private let userManager: UserManager
    
    // MARK: - Initialization
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    // MARK: - Private functions
    
    private func getCredentials(success: @escaping (AuthData) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        userManager.getCredentials(success: { authData in
            success(authData)
        }, failure: failure)
    }
    
    // MARK: - SagaDetailApiClientProtocol
    
    func setSaga(saga: SagaResponse, success: @escaping (SagaResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getCredentials(success: { authData in
            
            let request = SetSagaRequest(token: authData.token,
                                         saga: saga)
            APIClient.shared.sendServer(request, success: success, failure: failure)
        }, failure: failure)
    }
    
    func createSaga(saga: SagaResponse, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getCredentials(success: { authData in

            let request = CreateSagaRequest(token: authData.token,
                                            saga: saga)
            APIClient.shared.sendServer(request, success: success, failure: failure)
        }, failure: failure)
    }
}
