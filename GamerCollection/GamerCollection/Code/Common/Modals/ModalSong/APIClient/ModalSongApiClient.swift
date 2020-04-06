//
//  ModalSongApiClient.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 06/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalSongApiClientProtocol {
    func createSong(gameId: Int64, song: SongResponse, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class ModalSongApiClient: ModalSongApiClientProtocol {
    
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
    
    // MARK: - ModalSongApiClientProtocol
    
    func createSong(gameId: Int64, song: SongResponse, success: @escaping (EmptyResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getCredentials(success: { authData in
            
            let request = CreateSongRequest(token: authData.token,
                                            gameId: gameId,
                                            song: song)
            APIClient.shared.sendServer(request, success: success, failure: failure)
        }, failure: failure)
    }
}
