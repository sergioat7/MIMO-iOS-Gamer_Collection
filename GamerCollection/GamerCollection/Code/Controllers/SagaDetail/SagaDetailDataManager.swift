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
    func getSaga(success: @escaping (SagaResponse?) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getGames(success: @escaping (GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func setSaga(saga: SagaResponse, success: @escaping (SagaResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getSagaId() -> Int64?
}

class SagaDetailDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    private let apiClient: SagaDetailApiClientProtocol
    private let gameRepository: GameRepository
    private let sagaRepository: SagaRepository
    private let sagaId: Int64?
    
    // MARK: - Private variables
    
    // MARK: - Initialization
    
    init(apiClient: SagaDetailApiClientProtocol,
         gameRepository: GameRepository,
         sagaRepository: SagaRepository,
         sagaId: Int64?) {
        self.apiClient = apiClient
        self.gameRepository = gameRepository
        self.sagaRepository = sagaRepository
        self.sagaId = sagaId
    }
}

extension SagaDetailDataManager: SagaDetailDataManagerProtocol {
    
    func getSaga(success: @escaping (SagaResponse?) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        if let sagaId = getSagaId() {
            sagaRepository.get(id: sagaId, success: { sagaResponse in
                
                guard let selectedSaga = sagaResponse else {
                    let error = ErrorResponse(error: "ERROR_CORE_DATA".localized())
                    failure(error)
                    return
                }
                
                success(selectedSaga)
            }, failure: failure)
        } else {
            success(nil)
        }
    }
    
    func getGames(success: @escaping (GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        if let sagaId = getSagaId() {
            
            let predicate = NSPredicate(format: "(ANY saga.id = %ld)", sagaId)
            gameRepository.execute(predicate: predicate,
                                   sortDescriptors: nil,
                                   success: { (gameModels, _) in
                                    success(gameModels)
            }, failure: failure)
        } else {
            success([])
        }
    }
    
    func setSaga(saga: SagaResponse, success: @escaping (SagaResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        apiClient.setSaga(saga: saga, success: { sagaResponse in
            
            self.sagaRepository.update(item: sagaResponse, success: { _ in
                success(sagaResponse)
            }, failure: failure)
        }, failure: failure)
    }
    
    func getSagaId() -> Int64? {
        return sagaId
    }
}

