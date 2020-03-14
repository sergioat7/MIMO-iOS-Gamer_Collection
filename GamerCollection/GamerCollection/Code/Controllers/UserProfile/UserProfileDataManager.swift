//
//  UserProfileDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020. All rights reserved.
//

import UIKit

protocol UserProfileDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
}

class UserProfileDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    // MARK: - Initialization
    
    override init() {}
}

extension UserProfileDataManager: UserProfileDataManagerProtocol {
    
}

