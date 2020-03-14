//
//  UserData.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 13/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

struct UserData: Codable {
    var userName: String?
    var password: String?
    var isLoggedIn: Bool?
    
    init(userName: String,
         password: String,
         isLoggedIn: Bool) {
        
        self.userName = userName
        self.password = password
        self.isLoggedIn = isLoggedIn
    }
}
