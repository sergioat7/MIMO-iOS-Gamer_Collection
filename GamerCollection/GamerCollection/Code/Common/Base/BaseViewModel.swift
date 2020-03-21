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
    
    var logoutHandler: Selector?
    
    init(view: BaseViewProtocol) {
        self.view = view
    }
    
    func showNavBarButtons() {
        
        let rightBarButtonItems = getRightButtons()
        view?.showRighBarButtonItems(rightBarButtonItem: rightBarButtonItems)
    }
    
    // MARK: - Private functions
    
    private func getRightButtons() -> [UIBarButtonItem] {
        
        // MARK: Logout button
        let logoutButton = UIButton(type: .system)
        logoutButton.tintColor = Color.color1
        logoutButton.setImage(UIImage(named: "logout"), for: UIControl.State())
        let logoutButtonItem = UIBarButtonItem(customView: logoutButton)

        let rightBarButtonItems = [logoutButtonItem]
        if let logout = logoutHandler {
            logoutButton.addTarget(self, action: logout, for: .touchUpInside)
        }
        
        return rightBarButtonItems
    }
}
