//
//  LoginDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol LoginDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
}

class LoginDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let apiClient: LoginApiClientProtocol
    
    // MARK: - Initialization
    
    init(apiClient: LoginApiClientProtocol) {
        self.apiClient = apiClient
    }
}

extension LoginDataManager: LoginDataManagerProtocol {
    
}

