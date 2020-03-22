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
    func getGames(success: @escaping(GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getPlatforms(success: @escaping(PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getStates(success: @escaping(StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class GamesDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let apiClient: GamesApiClientProtocol
    private let gameRepository: GameRepository
    private let platformRepository: PlatformRepository
    private let stateRepository: StateRepository
    
    // MARK: - Initialization
    
    init(apiClient: GamesApiClientProtocol,
         gameRepository: GameRepository,
         platformRepository: PlatformRepository,
         stateRepository: StateRepository) {
        self.apiClient = apiClient
        self.gameRepository = gameRepository
        self.platformRepository = platformRepository
        self.stateRepository = stateRepository
    }
}

extension GamesDataManager: GamesDataManagerProtocol {
    
    func getGames(success: @escaping(GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        gameRepository.getAll(success: success, failure: failure)
    }
    
    func getPlatforms(success: @escaping(PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        platformRepository.getAll(success: success, failure: failure)
    }
    
    func getStates(success: @escaping(StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        stateRepository.getAll(success: success, failure: failure)
    }
}

