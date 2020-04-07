//
//  ModalSongDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 06/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalSongDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
    func createSong(song: SongResponse, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getGameId() -> Int64
}

class ModalSongDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let apiClient: ModalSongApiClientProtocol
    private let gameId: Int64
    
    // MARK: - Initialization
    
    init(apiClient: ModalSongApiClientProtocol,
         gameId: Int64) {
        self.apiClient = apiClient
        self.gameId = gameId
    }
}

extension ModalSongDataManager: ModalSongDataManagerProtocol {
    
    func createSong(song: SongResponse, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let gameId = getGameId()
        apiClient.createSong(gameId: gameId, song: song, success: { _ in
            success()
        }, failure: failure)
    }
    
    func getGameId() -> Int64 {
        return gameId
    }
}

