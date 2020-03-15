//
//  SagasDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol SagasDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
}

class SagasDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let apiClient: SagasApiClientProtocol
    
    // MARK: - Initialization
    
    init(apiClient: SagasApiClientProtocol) {
        self.apiClient = apiClient
    }
}

extension SagasDataManager: SagasDataManagerProtocol {
    
}

