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
    var addHandler: Selector?
    var filterHandler: Selector?
    var syncHandler: Selector?
    
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
        
        // MARK: Add button
        let addButton = UIButton(type: .system)
        addButton.tintColor = Color.color1
        addButton.setImage(UIImage(named: "add"), for: UIControl.State())
        let addButtonItem = UIBarButtonItem(customView: addButton)
        
        // MARK: Filter button
        let filterButton = UIButton(type: .system)
        filterButton.tintColor = Color.color1
        filterButton.setImage(UIImage(named: "filter"), for: UIControl.State())
        let filterButtonItem = UIBarButtonItem(customView: filterButton)
        
        // MARK: Sync button
        let syncButton = UIButton(type: .system)
        syncButton.tintColor = Color.color1
        syncButton.setImage(UIImage(named: "sync"), for: UIControl.State())
        let syncButtonItem = UIBarButtonItem(customView: syncButton)

        var rightBarButtonItems = [UIBarButtonItem]()
        
        if let logout = logoutHandler {
            logoutButton.addTarget(self, action: logout, for: .touchUpInside)
            rightBarButtonItems.append(logoutButtonItem)
        }
        
        if let add = addHandler {
            addButton.addTarget(self, action: add, for: .touchUpInside)
            rightBarButtonItems.append(addButtonItem)
        }
        
        if let filter = filterHandler {
            filterButton.addTarget(self, action: filter, for: .touchUpInside)
            rightBarButtonItems.append(filterButtonItem)
        }
        
        if let sync = syncHandler {
            syncButton.addTarget(self, action: sync, for: .touchUpInside)
            rightBarButtonItems.append(syncButtonItem)
        }
        
        return rightBarButtonItems
    }
}
