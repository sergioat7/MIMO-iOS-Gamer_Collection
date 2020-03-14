//
//  UserManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import KeychainAccess

class UserManager {
    
    private let defaultKeychain: Keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    
    func isLoggedIn() -> Bool {
        let userData: UserData? = getProperty(key: Constants.UserManagerKey.userData)
        let authData: AuthData? = getProperty(key: Constants.UserManagerKey.authData)
        return userData != nil && authData != nil
    }
    
    func storeUserData(userData: UserData) {
        setProperty(userData, forKey: Constants.UserManagerKey.userData)
    }
    
    func storeCredentials(authData: AuthData) {
        setProperty(authData, forKey: Constants.UserManagerKey.authData)
    }
    
    func getUserData(success: @escaping (UserData) -> Void,
                     failure: @escaping (ErrorResponse) -> Void) {
        
        guard let userData: UserData = getProperty(key: Constants.UserManagerKey.userData) else {
            let error = ErrorResponse(error: "ERROR_DATA".localized())
            failure(error)
            return
        }
        
        success(userData)
    }
    
    func getCredentials(success: @escaping (AuthData) -> Void,
                        failure: @escaping (ErrorResponse) -> Void) {
        
        guard let credentials: AuthData = getProperty(key: Constants.UserManagerKey.authData) else {
            let error = ErrorResponse(error: "ERROR_DATA".localized())
            failure(error)
            return
        }
        
        success(credentials)
    }
    
    func removeUserData() {
        removeProperty(key: Constants.UserManagerKey.userData)
    }
    
    func removeCredentials() {
        removeProperty(key: Constants.UserManagerKey.authData)
    }
    
}

extension UserManager {
    
    private func removeProperty(key: String) {
        defaultKeychain[string: key] = nil
    }
    
    private func setProperty(_ property: String?, forKey: String) {
        defaultKeychain[string: forKey] = property
    }
    
    private func setProperty<E: Codable>(_ property: E, forKey: String) {
        
        let jsonDataBase64String = try? JSONEncoder().encode(property).base64EncodedString()
        setProperty(jsonDataBase64String, forKey: forKey)
    }
    
    private func getProperty(key: String) -> String? {
        return defaultKeychain[string: key]
    }
    
    private func getProperty<E: Codable>(key: String) -> E? {
        
        let objectInBase64String = getProperty(key: key)
        return objectInBase64String.flatMap { Data.init(base64Encoded: $0) }
            .flatMap { try? JSONDecoder().decode(E.self, from: $0) }
    }
}
