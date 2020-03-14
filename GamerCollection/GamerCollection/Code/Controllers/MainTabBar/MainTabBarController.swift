//
//  MainTabBarController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    func configure() {
        
//        GamesController().presentTabBar()
//        SagasController().presentTabBar()
//        RankingController().presentTabBar()
//        UserProfileController().presentTabBar()
    }
    
    static func show() {
        
        let tabBarController = MainTabBarController()
        let window = UIViewController.getCurrentWindow()
        let navigationController = UINavigationController(rootViewController: tabBarController)
        window?.rootViewController = navigationController
        tabBarController.configure()
    }
}
