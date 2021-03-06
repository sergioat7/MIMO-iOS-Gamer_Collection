//
//  GameDetailApiClient.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 25/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol GameDetailApiClientProtocol {
    
    func setGame(game: GameResponse, success: @escaping (GameResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func deleteGame(gameId: Int64, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func deleteSong(gameId: Int64, songId: Int64, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func createGame(game: GameResponse, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getGame(gameId: Int64, success: @escaping (GameResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getGames(success: @escaping (GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class GameDetailApiClient: GameDetailApiClientProtocol {
    
    // MARK: - Private variables
    
    private let userManager: UserManager
    
    // MARK: - Initialization
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    // MARK: - Private functions
    
    private func getCredentials(success: @escaping (AuthData) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        userManager.getCredentials(success: { authData in
            success(authData)
        }, failure: failure)
    }
    
    // MARK: - GameDetailApiClientProtocol
    
    func setGame(game: GameResponse, success: @escaping (GameResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getCredentials(success: { authData in
            
            let request = SetGameRequest(token: authData.token,
                                         game: game)
            APIClient.shared.sendServer(request, success: success, failure: failure)
        }, failure: failure)
    }
    
    func deleteGame(gameId: Int64, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getCredentials(success: { authData in
            
            let request = DeleteGameRequest(token: authData.token,
                                            gameId: gameId)
            APIClient.shared.sendServer(request, success: success, failure: failure)
        }, failure: failure)
    }
    
    func deleteSong(gameId: Int64, songId: Int64, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getCredentials(success: { authData in
            
            let request = DeleteSongRequest(token: authData.token,
                                            gameId: gameId,
                                            songId: songId)
            APIClient.shared.sendServer(request, success: success, failure: failure)
        }, failure: failure)
    }
    
    func createGame(game: GameResponse, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getCredentials(success: { authData in
            
            let request = CreateGameRequest(token: authData.token,
                                            game: game)
            APIClient.shared.sendServer(request, success: success, failure: failure)
        }, failure: failure)
    }
    
    func getGame(gameId: Int64, success: @escaping (GameResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getCredentials(success: { authData in
            
            let request = GetGameRequest(token: authData.token,
                                         gameId: gameId)
            APIClient.shared.sendServer(request, success: success, failure: failure)
        }, failure: failure)
    }
    
    func getGames(success: @escaping (GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getCredentials(success: { authData in
            
            let request = GetGamesRequest(token: authData.token)
            APIClient.shared.sendServer(request, success: success, failure: failure)
        }, failure: failure)
    }
}
