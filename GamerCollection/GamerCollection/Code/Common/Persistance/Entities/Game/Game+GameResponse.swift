//
//  Game+GameResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 21/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import CoreData

extension Game: ModelHandlerProtocol {
    
    func storeEntity<M, R>(item: M,
                           context: NSManagedObjectContext,
                           success: @escaping (R) -> Void,
                           failure: @escaping (ErrorResponse) -> Void) {
        
        guard let item = item as? GameResponse else {
            let error = ErrorResponse(error: "ERROR_CORE_DATA")
            failure(error)
            return
        }
        
        let dateFormat = Locale.current.languageCode == "es" ? Constants.DateFormat.spanish : Constants.DateFormat.english
        
        id = item.id
        name = item.name
        platform = item.platform
        score = item.score
        pegi = item.pegi
        distributor = item.distributor
        developer = item.developer
        players = item.players
        releaseDate = item.releaseDate?.toDate(format: dateFormat)
        goty = item.goty
        format = item.format
        genre = item.genre
        state = item.state
        purchaseDate = item.purchaseDate?.toDate(format: dateFormat)
        purchaseLocation = item.purchaseLocation
        price = item.price
        imageUrl = item.imageUrl
        videoUrl = item.videoUrl
        loanedTo = item.loanedTo
        observations = item.observations
        
        manageSaga(item: item, failure: failure)
        
        do {
            try CoreDataStack.shared.saveContext(context)
        } catch {
            let error = ErrorResponse(error: "ERROR_CORE_DATA")
            failure(error)
        }
        
        guard let game = self as? R else {
            let error = ErrorResponse(error: "ERROR_CORE_DATA")
            failure(error)
            return
        }
        
        success(game)
    }
    
    func getModel<M>(success: @escaping (M) -> Void,
                     failure: @escaping (ErrorResponse) -> Void) {
        
        let dateFormat = Locale.current.languageCode == "es" ? Constants.DateFormat.spanish : Constants.DateFormat.english
        let releaseDate = self.releaseDate?.toString(format: dateFormat)
        let purchaseDate = self.purchaseDate?.toString(format: dateFormat)
        
        var saga: SagaResponse?
        self.saga?.getModel(success: { sagaResponse in
            saga = sagaResponse
        }, failure: failure)
        
        guard let gameResponse = GameResponse(id: id,
                                              name: name,
                                              platform: platform,
                                              score: score,
                                              pegi: pegi,
                                              distributor: distributor,
                                              developer: developer,
                                              players: players,
                                              releaseDate: releaseDate,
                                              goty: goty,
                                              format: format,
                                              genre: genre,
                                              state: state,
                                              purchaseDate: purchaseDate,
                                              purchaseLocation: purchaseLocation,
                                              price: price,
                                              imageUrl: imageUrl,
                                              videoUrl: videoUrl,
                                              loanedTo: loanedTo,
                                              observations: observations,
                                              saga: saga) as? M else {
                                                let error = ErrorResponse(error: "ERROR_CORE_DATA")
                                                failure(error)
                                                return
        }
        
        success(gameResponse)
    }
    
    // MARK: - Private functions
    
    private func manageSaga(item: GameResponse, failure: @escaping (ErrorResponse) -> Void) {
        
        let sagaRepository = SagaRepository()
        
        if let sagaId = item.saga?.id {
            sagaRepository.getRecords(success: { sagaRecords in
                self.saga = sagaRecords.first(where: { $0.id == sagaId })
            }, failure: failure)
        }
    }
}
