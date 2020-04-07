//
//  RegisterDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 15/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol RegisterDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
    func register(username: String, password: String, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void)
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func storeUserData(userData: UserData)
    func storeCredentials(authData: AuthData)
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getGenres(success: @escaping (GenresResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getPlatforms(success: @escaping (PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getStates(success: @escaping (StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class RegisterDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let apiClient: RegisterApiClientProtocol
    private let loginApiClient: LoginApiClientProtocol
    private let userManager: UserManager
    private let formatRepository: FormatRepository
    private let genreRepository: GenreRepository
    private let platformRepository: PlatformRepository
    private let stateRepository: StateRepository
    
    // MARK: - Initialization
    
    init(apiClient: RegisterApiClientProtocol,
         loginApiClient: LoginApiClientProtocol,
         userManager: UserManager,
         formatRepository: FormatRepository,
         genreRepository: GenreRepository,
         platformRepository: PlatformRepository,
         stateRepository: StateRepository) {
        self.apiClient = apiClient
        self.loginApiClient = loginApiClient
        self.userManager = userManager
        self.formatRepository = formatRepository
        self.genreRepository = genreRepository
        self.platformRepository = platformRepository
        self.stateRepository = stateRepository
    }
}

extension RegisterDataManager: RegisterDataManagerProtocol {
    
    func register(username: String, password: String, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        apiClient.register(username: username, password: password, success: {_ in success()}, failure: failure)
    }
    
    func login(username: String, password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        loginApiClient.login(username: username, password: password, success: success, failure: failure)
    }
    
    func storeUserData(userData: UserData) {
        userManager.storeUserData(userData: userData)
    }
    
    func storeCredentials(authData: AuthData) {
        userManager.storeCredentials(authData: authData)
    }
    
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
}

