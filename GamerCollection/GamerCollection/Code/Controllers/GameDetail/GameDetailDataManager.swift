//
//  GameDetailDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 25/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol GameDetailDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
}

class GameDetailDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    private let apiClient: GameDetailApiClientProtocol
    private let gameRepository: GameRepository
    private let formatRepository: FormatRepository
    private let platformRepository: PlatformRepository
    private let stateRepository: StateRepository
    private let gameId: Int64
    
    // MARK: - Private variables
    
    // MARK: - Initialization
    
    init(apiClient: GameDetailApiClientProtocol,
         gameRepository: GameRepository,
         formatRepository: FormatRepository,
         platformRepository: PlatformRepository,
         stateRepository: StateRepository,
         gameId: Int64) {
        self.apiClient = apiClient
        self.gameRepository = gameRepository
        self.formatRepository = formatRepository
        self.platformRepository = platformRepository
        self.stateRepository = stateRepository
        self.gameId = gameId
    }
}

extension GameDetailDataManager: GameDetailDataManagerProtocol {
    
}

