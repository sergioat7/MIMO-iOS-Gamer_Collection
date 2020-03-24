//
//  Constants.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 13/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

struct Constants {
    
    // MARK: - State constants
    
    struct State {
        static let pending: String = "PENDING"
        static let inProgress: String = "IN_PROGRESS"
        static let finished: String = "FINISHED"
    }
    
    // MARK: - Style constants
    
    struct Style {
        static let solidColor: CGFloat = 1.0
        static let lightColor: CGFloat = 0.75
        static let superLightColor: CGFloat = 0.5
    }
    
    // MARK: - UserManagerKey constants
    
    struct UserManagerKey {
        static let userData: String = "userData"
        static let authData: String = "authData"
        static let newInstallation: String = "newInstallation"
    }
    
    // MARK: - NavBar constants
    
    struct NavBar {
        static let space: CGFloat = 15
    }
}
