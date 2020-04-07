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
    func getGame(success: @escaping (GameResponse?) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getGenres(success: @escaping (GenresResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getPlatforms(success: @escaping (PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getStates(success: @escaping (StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func setGame(game: GameResponse, success: @escaping (GameResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func deleteGame(success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void)
    func deleteSong(songId: Int64, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void)
    func createGame(game: GameResponse, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void)
    func updateGame(success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getGameId() -> Int64?
}

class GameDetailDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let apiClient: GameDetailApiClientProtocol
    private let gameRepository: GameRepository
    private let formatRepository: FormatRepository
    private let genreRepository: GenreRepository
    private let platformRepository: PlatformRepository
    private let stateRepository: StateRepository
    private let songRepository: SongRepository
    private let gameId: Int64?
    
    // MARK: - Initialization
    
    init(apiClient: GameDetailApiClientProtocol,
         gameRepository: GameRepository,
         formatRepository: FormatRepository,
         genreRepository: GenreRepository,
         platformRepository: PlatformRepository,
         stateRepository: StateRepository,
         songRepository: SongRepository,
         gameId: Int64?) {
        self.apiClient = apiClient
        self.gameRepository = gameRepository
        self.formatRepository = formatRepository
        self.genreRepository = genreRepository
        self.platformRepository = platformRepository
        self.stateRepository = stateRepository
        self.songRepository = songRepository
        self.gameId = gameId
    }
}

extension GameDetailDataManager: GameDetailDataManagerProtocol {
    
    func getGame(success: @escaping (GameResponse?) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        if let gameId = getGameId() {
            gameRepository.get(id: gameId, success: { gameResponse in
                
                guard let selectedGame = gameResponse else {
                    let error = ErrorResponse(error: "ERROR_CORE_DATA".localized())
                    failure(error)
                    return
                }
                
                success(selectedGame)
            }, failure: failure)
        } else {
            success(nil)
        }
    }
    
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        formatRepository.getAll(success: success, failure: failure)
    }
    
    func getGenres(success: @escaping (GenresResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        genreRepository.getAll(success: success, failure: failure)
    }
    
    func getPlatforms(success: @escaping (PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        platformRepository.getAll(success: success, failure: failure)
    }
    
    func getStates(success: @escaping (StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        stateRepository.getAll(success: success, failure: failure)
    }
    
    func setGame(game: GameResponse, success: @escaping (GameResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        apiClient.setGame(game: game, success: { gameResponse in
            
            self.gameRepository.update(item: gameResponse, success: { _ in
                success(gameResponse)
            }, failure: failure)
        }, failure: failure)
    }
    
    func deleteGame(success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        if let gameId = getGameId() {
            apiClient.deleteGame(gameId: gameId, success: { _ in
                self.gameRepository.delete(id: gameId, success: success, failure: failure)
            }, failure: failure)
        } else {
            success()
        }
    }
    
    func deleteSong(songId: Int64, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        if let gameId = getGameId() {
            apiClient.deleteSong(gameId: gameId,
                                 songId: songId,
                                 success: { _ in
                                    self.songRepository.delete(id: songId, success: success, failure: failure)
            }, failure: failure)
        } else {
            success()
        }
    }
    
    func createGame(game: GameResponse, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        apiClient.createGame(game: game, success: { _ in
            success()
        }, failure: failure)
    }
    
    func updateGame(success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        if let gameId = getGameId() {
            apiClient.getGame(gameId: gameId, success: { gameResponse in
                
                self.gameRepository.update(item: gameResponse, success: { _ in
                    success()
                }, failure: failure)
            }, failure: failure)
        }
    }
    
    func getGameId() -> Int64? {
        return gameId
    }
}

