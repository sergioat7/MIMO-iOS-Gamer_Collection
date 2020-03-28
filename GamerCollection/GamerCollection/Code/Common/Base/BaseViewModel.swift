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
    var editHandler: Selector?
    var saveHandler: Selector?
    var cancelHandler: Selector?
    
    init(view: BaseViewProtocol) {
        self.view = view
    }
    
    func showNavBarButtons() {
        
        let rightBarButtonItems = getRightButtons()
        view?.showRightBarButtonItems(rightBarButtonItems: rightBarButtonItems)
    }
    
    func showSaveCancelButtons() {
        
        // MARK: Save button
        let saveButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: saveHandler)
        
        // MARK: Cancel button
        let cancelButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: cancelHandler)
        
        view?.showRightBarButtonItems(rightBarButtonItems: [saveButtonItem])
        
        view?.showLeftBarButtonItems(leftBarButtonItems: [cancelButtonItem])
    }
    
    // MARK: - Private functions
    
    private func getRightButtons() -> [UIBarButtonItem] {
        
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        space.width = Constants.NavBar.space
        
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
        
        // MARK: Edit button
        let editButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: editHandler)

        var rightBarButtonItems = [UIBarButtonItem]()
        
        if let logout = logoutHandler {
            logoutButton.addTarget(self, action: logout, for: .touchUpInside)
            rightBarButtonItems.append(logoutButtonItem)
            rightBarButtonItems.append(space)
        }
        
        if let add = addHandler {
            addButton.addTarget(self, action: add, for: .touchUpInside)
            rightBarButtonItems.append(addButtonItem)
            rightBarButtonItems.append(space)
        }
        
        if let filter = filterHandler {
            filterButton.addTarget(self, action: filter, for: .touchUpInside)
            rightBarButtonItems.append(filterButtonItem)
            rightBarButtonItems.append(space)
        }
        
        if let _ = editHandler {
            rightBarButtonItems.append(editButtonItem)
            rightBarButtonItems.append(space)
        }
        
        syncButton.addTarget(self, action: #selector(openSyncPopup), for: .touchUpInside)
        rightBarButtonItems.append(syncButtonItem)
        rightBarButtonItems.append(space)
        
        rightBarButtonItems.removeLast()
        
        return rightBarButtonItems
    }
    
    // MARK: - Private functions
    
    @objc private func openSyncPopup() {
        
        view?.showConfirmationDialog(message: "SYNC_CONFIRMATION".localized(), handler: {
            let viewControllerToPresent = ModalSyncAppRouter().view
            self.view?.showSyncPopup(viewControllerToPresent: viewControllerToPresent)
        }, handlerCancel: nil)
    }
}
