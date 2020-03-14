//
//  MainTabBarController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    func configure() {
        
        GamesRouter().presentTabBar()
        SagasRouter().presentTabBar()
        RankingRouter().presentTabBar()
        UserProfileRouter().presentTabBar()
    }
    
    static func show() {
        
        let tabBarController = MainTabBarController()
        let window = UIViewController.getCurrentWindow()
        window?.rootViewController = tabBarController
        tabBarController.configure()
    }
}
