//
//  ModalSongDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 06/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalSongDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
}

class ModalSongDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    private let apiClient: ModalSongApiClientProtocol
    
    // MARK: - Private variables
    
    // MARK: - Initialization
    
    init(apiClient: ModalSongApiClientProtocol) {
        self.apiClient = apiClient
    }
}

extension ModalSongDataManager: ModalSongDataManagerProtocol {
    
}

