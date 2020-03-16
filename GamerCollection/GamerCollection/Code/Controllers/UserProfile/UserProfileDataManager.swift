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
    func getUserData(success: @escaping (UserData) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class UserProfileDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    private let apiClient: UserProfileApiClientProtocol
    private let userManager: UserManager
    
    // MARK: - Private variables
    
    // MARK: - Initialization
    
    init(apiClient: UserProfileApiClientProtocol,
    userManager: UserManager) {
        self.apiClient = apiClient
        self.userManager = userManager
    }
}

extension UserProfileDataManager: UserProfileDataManagerProtocol {
    
    func getUserData(success: @escaping (UserData) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        userManager.getUserData(success: { userData in
            success(userData)
        }, failure: failure)
    }
}

