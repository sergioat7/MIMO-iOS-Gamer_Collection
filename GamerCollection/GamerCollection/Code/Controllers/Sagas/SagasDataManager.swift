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
     func getSagas(success: @escaping(SagasResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
     func getGames(sagas: SagasResponse, success: @escaping(GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
     func getPlatforms(success: @escaping(PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
     func getStates(success: @escaping(StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class SagasDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let apiClient: SagasApiClientProtocol
    private let gameRepository: GameRepository
    private let sagaRepository: SagaRepository
    private let platformRepository: PlatformRepository
    private let stateRepository: StateRepository
    
    // MARK: - Initialization
    
    init(apiClient: SagasApiClientProtocol,
         gameRepository: GameRepository,
         sagaRepository: SagaRepository,
         platformRepository: PlatformRepository,
         stateRepository: StateRepository) {
        self.apiClient = apiClient
        self.gameRepository = gameRepository
        self.sagaRepository = sagaRepository
        self.platformRepository = platformRepository
        self.stateRepository = stateRepository
    }
}

extension SagasDataManager: SagasDataManagerProtocol {

    func getSagas(success: @escaping(SagasResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        var sortDescriptors = [NSSortDescriptor]()
        sortDescriptors.append(NSSortDescriptor(key: "name", ascending: true))
        sortDescriptors.append(NSSortDescriptor(key: "id", ascending: true))
        
        sagaRepository.execute(predicate: predicate,
                               sortDescriptors: sortDescriptors,
                               success: { (sagaModels, _) in
                                success(sagaModels)
        }, failure: failure)
    }

    func getGames(sagas: SagasResponse, success: @escaping(GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        var sagasId = [Int64]()
        for saga in sagas {
            sagasId.append(saga.id)
        }
        
        let predicate = NSPredicate(format: "(ANY saga.id IN %@)", sagasId)
        gameRepository.execute(predicate: predicate,
                               sortDescriptors: nil,
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

