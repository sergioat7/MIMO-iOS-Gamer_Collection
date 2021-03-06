//
//  ModalSyncAppDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 24/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalSyncAppDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getGenres(success: @escaping (GenresResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getPlatforms(success: @escaping (PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getStates(success: @escaping (StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getGames(success: @escaping (GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getSagas(success: @escaping (SagasResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class ModalSyncAppDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let loginApiClient: LoginApiClientProtocol
    private let formatRepository: FormatRepository
    private let genreRepository: GenreRepository
    private let platformRepository: PlatformRepository
    private let stateRepository: StateRepository
    private let gameRepository: GameRepository
    private let sagaRepository: SagaRepository
    
    // MARK: - Initialization
    
    init(loginApiClient: LoginApiClientProtocol,
         formatRepository: FormatRepository,
         genreRepository: GenreRepository,
         platformRepository: PlatformRepository,
         stateRepository: StateRepository,
         gameRepository: GameRepository,
         sagaRepository: SagaRepository) {
        self.loginApiClient = loginApiClient
        self.formatRepository = formatRepository
        self.genreRepository = genreRepository
        self.platformRepository = platformRepository
        self.stateRepository = stateRepository
        self.gameRepository = gameRepository
        self.sagaRepository = sagaRepository
    }
}

extension ModalSyncAppDataManager: ModalSyncAppDataManagerProtocol {
    
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        loginApiClient.getFormats(success: { formats in
            
            self.formatRepository.getDisabledContent(enabledContent: formats,
                                                     predicate: NSPredicate(value: true),
                                                     success: { disableFormats in
                                                        
                                                        for disableFormat in disableFormats {
                                                            self.formatRepository.delete(id: disableFormat.id, success: {}, failure: failure)
                                                        }
                                                        
                                                        guard !formats.isEmpty else {
                                                            success(formats)
                                                            return
                                                        }
                                                        
                                                        for (index, format) in formats.enumerated() {
                                                            self.formatRepository.update(item: format, success: { _ in
                                                                
                                                                if index == formats.count - 1 {
                                                                    success(formats)
                                                                }
                                                            }, failure: failure)
                                                        }
            }, failure: failure)
        }, failure: failure)
    }
    
    func getGenres(success: @escaping (GenresResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        loginApiClient.getGenres(success: { genres in
            
            self.genreRepository.getDisabledContent(enabledContent: genres,
                                                    predicate: NSPredicate(value: true),
                                                    success: { disabledGenres in
                                                        
                                                        for disabledGenre in disabledGenres {
                                                            self.genreRepository.delete(id: disabledGenre.id, success: {}, failure: failure)
                                                        }
                                                        
                                                        guard !genres.isEmpty else {
                                                            success(genres)
                                                            return
                                                        }
                                                        
                                                        for (index, genre) in genres.enumerated() {
                                                            self.genreRepository.update(item: genre, success: { _ in
                                                                
                                                                if index == genres.count - 1 {
                                                                    success(genres)
                                                                }
                                                            }, failure: failure)
                                                        }
            }, failure: failure)
        }, failure: failure)
    }
    
    func getPlatforms(success: @escaping (PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        loginApiClient.getPlatforms(success: { platforms in
            
            self.platformRepository.getDisabledContent(enabledContent: platforms,
                                                       predicate: NSPredicate(value: true),
                                                       success: { disabledPlatforms in
                                                        
                                                        for disabledPlatform in disabledPlatforms {
                                                            self.platformRepository.delete(id: disabledPlatform.id, success: {}, failure: failure)
                                                        }
                                                        
                                                        guard !platforms.isEmpty else {
                                                            success(platforms)
                                                            return
                                                        }
                                                        
                                                        for (index, platform) in platforms.enumerated() {
                                                            self.platformRepository.update(item: platform, success: { _ in
                                                                
                                                                if index == platforms.count - 1 {
                                                                    success(platforms)
                                                                }
                                                            }, failure: failure)
                                                        }
            }, failure: failure)
        }, failure: failure)
    }
    
    func getStates(success: @escaping (StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        loginApiClient.getStates(success: { states in
            
            self.stateRepository.getDisabledContent(enabledContent: states,
                                                    predicate: NSPredicate(value: true),
                                                    success: { disabledStates in
                                                        
                                                        for disabledState in disabledStates {
                                                            self.stateRepository.delete(id: disabledState.id, success: {}, failure: failure)
                                                        }
                                                        
                                                        guard !states.isEmpty else {
                                                            success(states)
                                                            return
                                                        }
                                                        
                                                        for (index, state) in states.enumerated() {
                                                            self.stateRepository.update(item: state, success: { _ in
                                                                
                                                                if index == states.count - 1 {
                                                                    success(states)
                                                                }
                                                            }, failure: failure)
                                                        }
            }, failure: failure)
        }, failure: failure)
    }
    
    func getGames(success: @escaping (GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        loginApiClient.getGames(success: { games in
        
        self.gameRepository.getDisabledContent(enabledContent: games,
                                               predicate: NSPredicate(value: true),
                                               success: { disabledGames in
                                                
                                                for disabledGame in disabledGames {
                                                    self.gameRepository.delete(id: disabledGame.id, success: {}, failure: failure)
                                                }
                                                
                                                guard !games.isEmpty else {
                                                    success(games)
                                                    return
                                                }
                                                
                                                for (index, game) in games.enumerated() {
                                                    self.gameRepository.update(item: game, success: { _ in
                                                        
                                                        if index == games.count - 1 {
                                                            success(games)
                                                        }
                                                    }, failure: failure)
                                                }
        }, failure: failure)
        }, failure: failure)
    }
    
    func getSagas(success: @escaping (SagasResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        loginApiClient.getSagas(success: { sagas in
            
            self.sagaRepository.getDisabledContent(enabledContent: sagas,
                                                   predicate: NSPredicate(value: true),
                                                   success: { disabledSagas in
                                                    
                                                    for disableSaga in disabledSagas {
                                                        self.sagaRepository.delete(id: disableSaga.id, success: {}, failure: failure)
                                                    }
                                                    
                                                    guard !sagas.isEmpty else {
                                                        success(sagas)
                                                        return
                                                    }
                                                    
                                                    for (index, saga) in sagas.enumerated() {
                                                        self.sagaRepository.update(item: saga, success: { _ in
                                                            
                                                            if index == sagas.count - 1 {
                                                                success(sagas)
                                                            }
                                                        }, failure: failure)
                                                    }
            }, failure: failure)
        }, failure: failure)
    }
}

