//
//  LoginDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol LoginDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
    func getUsername(success: @escaping (String?) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func storeUserData(userData: UserData)
    func storeCredentials(authData: AuthData)
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getGenres(success: @escaping (GenresResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getPlatforms(success: @escaping (PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class LoginDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let apiClient: LoginApiClientProtocol
    private let userManager: UserManager
    private let formatRepository: FormatRepository
    private let genreRepository: GenreRepository
    private let platformRepository: PlatformRepository
    
    // MARK: - Initialization
    
    init(apiClient: LoginApiClientProtocol,
         userManager: UserManager,
         formatRepository: FormatRepository,
         genreRepository: GenreRepository,
         platformRepository: PlatformRepository) {
        self.apiClient = apiClient
        self.userManager = userManager
        self.formatRepository = formatRepository
        self.genreRepository = genreRepository
        self.platformRepository = platformRepository
    }
}

extension LoginDataManager: LoginDataManagerProtocol {
    
    func getUsername(success: @escaping (String?) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        userManager.getUserData(success: { userData in
            success(userData.userName)
        }, failure: failure)
    }
    
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        apiClient.login(username: username, password: password, success: success, failure: failure)
    }
    
    func storeUserData(userData: UserData) {
        userManager.storeUserData(userData: userData)
    }
    
    func storeCredentials(authData: AuthData) {
        userManager.storeCredentials(authData: authData)
    }
    
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        apiClient.getFormats(success: { formats in
            
            for (index, format) in formats.enumerated() {
                self.formatRepository.update(item: format, success: { _ in
                    
                    if index == formats.count - 1 {
                        success(formats)
                    }
                }, failure: failure)
            }
        }, failure: failure)
    }
    
    func getGenres(success: @escaping (GenresResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        apiClient.getGenres(success: { genres in
            
            for (index, genre) in genres.enumerated() {
                self.genreRepository.update(item: genre, success: { _ in
                    if index == genres.count - 1 {
                        success(genres)
                    }
                }, failure: failure)
            }
        }, failure: failure)
    }
    
    func getPlatforms(success: @escaping (PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        apiClient.getPlatforms(success: { platforms in
            
            for (index, platform) in platforms.enumerated() {
                self.platformRepository.update(item: platform, success: { _ in
                    if index == platforms.count - 1 {
                        success(platforms)
                    }
                }, failure: failure)
            }
        }, failure: failure)
    }
}

