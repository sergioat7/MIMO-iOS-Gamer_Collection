//
//  UserProfileDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 16/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol UserProfileDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
}

class UserProfileDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    private let apiClient: UserProfileApiClientProtocol
    
    // MARK: - Private variables
    
    // MARK: - Initialization
    
    init(apiClient: UserProfileApiClientProtocol) {
        self.apiClient = apiClient
    }
}

extension UserProfileDataManager: UserProfileDataManagerProtocol {
    
}

