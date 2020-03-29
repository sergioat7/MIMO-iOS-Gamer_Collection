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
    func getGames(state: String?, success: @escaping(GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getFormats(success: @escaping(FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getPlatforms(success: @escaping(PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getStates(success: @escaping(StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class GamesDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let apiClient: GamesApiClientProtocol
    private let gameRepository: GameRepository
    private let formatRepository: FormatRepository
    private let platformRepository: PlatformRepository
    private let stateRepository: StateRepository
    
    // MARK: - Initialization
    
    init(apiClient: GamesApiClientProtocol,
         gameRepository: GameRepository,
         formatRepository: FormatRepository,
         platformRepository: PlatformRepository,
         stateRepository: StateRepository) {
        self.apiClient = apiClient
        self.gameRepository = gameRepository
        self.formatRepository = formatRepository
        self.platformRepository = platformRepository
        self.stateRepository = stateRepository
    }
}

extension GamesDataManager: GamesDataManagerProtocol {
    
    func getGames(state: String?, success: @escaping(GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        var predicate: NSPredicate
        switch state {
        case Constants.State.pending:
            predicate = NSPredicate(format: "state = %@", Constants.State.pending)
        case Constants.State.inProgress:
            predicate = NSPredicate(format: "state = %@", Constants.State.inProgress)
        case Constants.State.finished:
            predicate = NSPredicate(format: "state = %@", Constants.State.finished)
        default:
            predicate = NSPredicate(value: true)
        }
        
        var sortDescriptors = [NSSortDescriptor]()
        sortDescriptors.append(NSSortDescriptor(key: "name", ascending: true))
        sortDescriptors.append(NSSortDescriptor(key: "id", ascending: true))
        gameRepository.execute(predicate: predicate,
                               sortDescriptors: sortDescriptors,
                               success: { (gameModels, _) in
                                success(gameModels)
        }, failure: failure)
    }
    
    func getFormats(success: @escaping(FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        formatRepository.getAll(success: success, failure: failure)
    }
    
    func getPlatforms(success: @escaping(PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        platformRepository.getAll(success: success, failure: failure)
    }
    
    func getStates(success: @escaping(StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        stateRepository.getAll(success: success, failure: failure)
    }
}

