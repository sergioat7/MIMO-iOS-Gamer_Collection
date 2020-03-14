//
//  AppDelegate.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 08/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if UserManager().isLoggedIn() {
            MainTabBarController.show()
        } else {
            LoginRouter().show()
        }
        
        window?.makeKeyAndVisible()
        return true
    }

}

