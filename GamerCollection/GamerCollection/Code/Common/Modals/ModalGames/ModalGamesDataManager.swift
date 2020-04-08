//
//  ModalGamesDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalGamesDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
     func getGames(success: @escaping(GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
     func getPlatforms(success: @escaping(PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
     func getStates(success: @escaping(StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class ModalGamesDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    // MARK: - Initialization
    
    private let gameRepository: GameRepository
    private let platformRepository: PlatformRepository
    private let stateRepository: StateRepository
    
    // MARK: - Initialization
    
    init(gameRepository: GameRepository,
         platformRepository: PlatformRepository,
         stateRepository: StateRepository) {
        self.gameRepository = gameRepository
        self.platformRepository = platformRepository
        self.stateRepository = stateRepository
    }
}

extension ModalGamesDataManager: ModalGamesDataManagerProtocol {
    
    func getGames(success: @escaping(GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        var sortDescriptors = [NSSortDescriptor]()
        sortDescriptors.append(NSSortDescriptor(key: "name", ascending: true))
        sortDescriptors.append(NSSortDescriptor(key: "id", ascending: true))
        
        gameRepository.execute(predicate: predicate,
                               sortDescriptors: sortDescriptors,
                               success: { (gameModels, _) in
                                success(gameModels)
        }, failure: failure)
    }
    
    func getPlatforms(success: @escaping(PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        platformRepository.getAll(success: success, failure: failure)
    }
    
    func getStates(success: @escaping(StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        stateRepository.getAll(success: success, failure: failure)
    }
}

