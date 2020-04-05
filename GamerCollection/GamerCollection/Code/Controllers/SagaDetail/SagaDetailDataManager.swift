//
//  SagaDetailDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol SagaDetailDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
}

class SagaDetailDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    private let apiClient: SagaDetailApiClientProtocol
    
    // MARK: - Private variables
    
    // MARK: - Initialization
    
    init(apiClient: SagaDetailApiClientProtocol) {
        self.apiClient = apiClient
    }
}

extension SagaDetailDataManager: SagaDetailDataManagerProtocol {
    
}

