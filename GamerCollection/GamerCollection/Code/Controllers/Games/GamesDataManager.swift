//
//  GamesDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol GamesDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
}

class GamesDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let apiClient: GamesApiClientProtocol
    
    // MARK: - Initialization
    
    init(apiClient: GamesApiClientProtocol) {
        self.apiClient = apiClient
    }
}

extension GamesDataManager: GamesDataManagerProtocol {
    
}

