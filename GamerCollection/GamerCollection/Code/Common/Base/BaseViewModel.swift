//
//  BaseViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 08/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class BaseViewModel {
    
    private weak var view:BaseViewProtocol?
    
    init(view: BaseViewProtocol) {
        self.view = view
    }
    
    func getRightButtons() -> [UIBarButtonItem] {
        
        // MARK: Logout button
        let logoutButton = UIButton(type: .system)
        logoutButton.tintColor = Color.color1
        logoutButton.setImage(UIImage(named: "logout"), for: UIControl.State())
        let logoutButtonItem = UIBarButtonItem(customView: logoutButton)

        let rightBarButtonItems = [logoutButtonItem]
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        return rightBarButtonItems
    }
    
    func showNavBarButtons() {
        
        let rightBarButtonItems = getRightButtons()
        view?.showRighBarButtonItems(rightBarButtonItem: rightBarButtonItems)
    }
    
    // MARK: - Private functions
    
    @objc private func logout() {
        
        view?.showConfirmationDialog(message: "PROFILE_LOGOUT_CONFIRMATION".localized(), handler: {
            
            self.view?.showLoading()
            let userManager = UserManager()
            let userProfileApiClient = UserProfileApiClient(userManager: userManager)
            userProfileApiClient.logout(success: { _ in
                
                userManager.removePassword()
                userManager.removeCredentials()
                LoginRouter().show()
            }, failure: { error in
                self.view?.hideLoading()
                self.view?.showError(message: error.error, handler: nil)
            })
        }, handlerCancel: nil)
    }
}
