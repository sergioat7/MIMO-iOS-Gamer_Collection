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
    func getSelectedGames(gameIds: [Int64], success: @escaping (GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func deleteSaga(success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void)
    func setSaga(saga: SagaResponse, success: @escaping (SagaResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func createSaga(saga: SagaResponse, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void)
    func updateSagas(success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void)
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
            
            let predicate = NSPredicate(format: "ANY saga.id = %ld", sagaId)
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            gameRepository.execute(predicate: predicate,
                                   sortDescriptors: [sortDescriptor],
                                   success: { (gameModels, _) in
                                    success(gameModels)
            }, failure: failure)
        } else {
            success([])
        }
    }
    
    func getSelectedGames(gameIds: [Int64], success: @escaping (GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let predicate = NSPredicate(format: "ANY id IN %@", gameIds)
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        gameRepository.execute(predicate: predicate,
                               sortDescriptors: [sortDescriptor],
                               success: { (gameModels, _) in
                               success(gameModels)
        }, failure: failure)
    }
    
    func setSaga(saga: SagaResponse, success: @escaping (SagaResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        apiClient.setSaga(saga: saga, success: { sagaResponse in
            
            self.removeSagaFromGames(saga: saga, success: {
                self.sagaRepository.update(item: sagaResponse, success: { _ in
                    success(sagaResponse)
                }, failure: failure)
            }, failure: failure)
        }, failure: failure)
    }
    
    func deleteSaga(success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        if let sagaId = getSagaId() {
            apiClient.deleteSaga(sagaId: sagaId, success: { _ in
                self.sagaRepository.delete(id: sagaId, success: success, failure: failure)
            }, failure: failure)
        } else {
            success()
        }
    }
    
    func createSaga(saga: SagaResponse, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        apiClient.createSaga(saga: saga, success: { _ in
            success()
        }, failure: failure)
    }
    
    func updateSagas(success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        apiClient.getSagas(success: { sagas in
            
            guard !sagas.isEmpty else {
                success()
                return
            }
            
            for (index, saga) in sagas.enumerated() {
                self.sagaRepository.update(item: saga, success: { _ in
                    
                    if index == sagas.count - 1 {
                        success()
                    }
                }, failure: failure)
            }
        }, failure: failure)
    }
    
    func getSagaId() -> Int64? {
        return sagaId
    }
    
    // MARK: - Private functions
    
    private func removeSagaFromGames(saga: SagaResponse, success: @escaping() -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        self.getGames(success: { games in
            
            if !games.isEmpty {
                for (index,game) in games.enumerated() {
                    if !saga.games.contains(where: { $0.id == game.id }) {
                        
                        var gameVar = game
                        gameVar.saga = nil
                        self.gameRepository.update(item: gameVar, success: { _ in
                            
                            if index == games.count-1 {
                                success()
                            }
                        }, failure: failure)
                    } else {
                        if index == games.count-1 {
                            success()
                        }
                    }
                }
            } else {
                success()
            }
        }, failure: failure)
    }
}

