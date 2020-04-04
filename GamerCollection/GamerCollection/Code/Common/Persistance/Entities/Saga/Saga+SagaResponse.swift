//
//  Saga+SagaResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 04/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import CoreData

extension Saga: ModelHandlerProtocol {
    
    func storeEntity<M, R>(item: M,
                           context: NSManagedObjectContext,
                           success: @escaping (R) -> Void,
                           failure: @escaping (ErrorResponse) -> Void) {
        
        guard let item = item as? SagaResponse else {
            let error = ErrorResponse(error: "ERROR_CORE_DATA")
            failure(error)
            return
        }
        
        id = item.id
        name = item.name
        
        manageGames(item: item, failure: failure)
        
        do {
            try CoreDataStack.shared.saveContext(context)
        } catch {
            let error = ErrorResponse(error: "ERROR_CORE_DATA")
            failure(error)
        }
        
        guard let saga = self as? R else {
            let error = ErrorResponse(error: "ERROR_CORE_DATA")
            failure(error)
            return
        }
        
        success(saga)
    }
    
    func getModel<M>(success: @escaping (M) -> Void,
                     failure: @escaping (ErrorResponse) -> Void) {
                
        guard let sagaResponse = SagaResponse(id: id,
                                              name: name,
                                              games: []) as? M else {
                                                let error = ErrorResponse(error: "ERROR_CORE_DATA")
                                                failure(error)
                                                return
        }
        
        success(sagaResponse)
    }
    
    // MARK: - Private functions
    
    private func manageGames(item: SagaResponse, failure: @escaping (ErrorResponse) -> Void) {
        
        let gameRepository = GameRepository()
        
        for game in item.games {
            
            gameRepository.update(item: game, success: { gameResponse in
                self.addToGames(gameResponse)
            }, failure: failure)
        }
    }
}
