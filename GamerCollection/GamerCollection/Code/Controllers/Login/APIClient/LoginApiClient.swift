//
//  LoginApiClient.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol LoginApiClientProtocol {
    
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getGenres(success: @escaping (GenresResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getPlatforms(success: @escaping (PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getStates(success: @escaping (StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getGames(success: @escaping (GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class LoginApiClient: LoginApiClientProtocol {
    
    private let userManager: UserManager
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    func getCredentials(success: @escaping (AuthData) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        userManager.getCredentials(success: { authData in
            success(authData)
        }, failure: failure)
    }
    
    // MARK: - UserProfileApiClientProtocol
    
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let loginParameters = LoginDataModelRequest(username: username,
                                                    password: password)
        let request = LoginRequest(loginDataModelRequest: loginParameters)
        APIClient.shared.sendServer(request, success: success, failure: failure)
    }
    
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let request = GetFormatsRequest()
        APIClient.shared.sendServer(request, success: success, failure: failure)
    }
    
    func getGenres(success: @escaping (GenresResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let request = GetGenresRequest()
        APIClient.shared.sendServer(request, success: success, failure: failure)
    }
    
    func getPlatforms(success: @escaping (PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let request = GetPlatformsRequest()
        APIClient.shared.sendServer(request, success: success, failure: failure)
    }
    
    func getStates(success: @escaping (StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let request = GetStatesRequest()
        APIClient.shared.sendServer(request, success: success, failure: failure)
    }
    
    func getGames(success: @escaping (GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getCredentials(success: { authData in
            
            let request = GetGamesRequest(token: authData.token)
            APIClient.shared.sendServer(request, success: success, failure: failure)
        }, failure: failure)
    }
}
