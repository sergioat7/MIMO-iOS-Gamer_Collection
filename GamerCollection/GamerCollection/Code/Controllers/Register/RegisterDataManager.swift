//
//  RegisterDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 15/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol RegisterDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
    func register(username: String, password: String, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class RegisterDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let apiClient: RegisterApiClientProtocol
    // MARK: - Initialization
    
    init(apiClient: RegisterApiClientProtocol) {
        self.apiClient = apiClient
    }
}

extension RegisterDataManager: RegisterDataManagerProtocol {
    
    func register(username: String, password: String, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        apiClient.register(username: username, password: password, success: {_ in success()}, failure: failure)
    }
}

