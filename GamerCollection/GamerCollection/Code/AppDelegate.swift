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
        
        if CommandLine.arguments.contains("--uitesting") {
            resetState()
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        checkIsNewInstallation()
        showMainView()
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func checkIsNewInstallation() {
        
        let userManager = UserManager()
        if userManager.isNewInstallation() {
            userManager.removeUserData()
            userManager.removeCredentials()
            userManager.setIsNewInstallation()
        }
    }

    func showMainView() {
        
        if UserManager().isLoggedIn() {
            MainTabBarController.show()
        } else {
            LoginRouter().show()
        }
    }
    
    // MARK: - Private functions
    
    private func resetState() {
        
        let userManager = UserManager()
        userManager.removeUserData()
        userManager.removeCredentials()
    }
}

