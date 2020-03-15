//
//  BaseViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 08/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import PopupDialog

protocol BaseViewProtocol: class {
    
    func showLoading()
    func hideLoading()
    func showError(message: String, handler: (() -> Void)?)
}

class BaseViewController: UIViewController {
    
    var loadingScreen = LoadingScreen()
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.color1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let message = "Showing " + NSStringFromClass(self.classForCoder)
        print(message)
    }
    
    func showLoading() {
        loadingScreen.show(view: view)
        isLoading = true
    }
    
    func hideLoading() {
        loadingScreen.hide(completion: nil)
        isLoading = false
    }
    
    func showError(message: String, handler: (() -> Void)?) {
        
        let popup = PopupDialog(title: "app_name".localized(),
                                message: message.localized())
        setupDialog()
        
        let button = DefaultButton(title: "ERROR_BUTTON_ACCEPT".localized(), dismissOnTap: true) {
            handler?()
        }
     
        popup.addButtons([button])
        present(popup, animated: true, completion: nil)
        
    }
    
    // MARK: - Private functions
    
    private func setupDialog() {
        let dialogAppearance = PopupDialogDefaultView.appearance()
        
        dialogAppearance.backgroundColor = .white
        dialogAppearance.titleColor = .black
        dialogAppearance.titleTextAlignment = .center
        dialogAppearance.messageColor = .black
        dialogAppearance.messageTextAlignment = .center
        
        let buttonAppearance = DefaultButton.appearance()
        buttonAppearance.titleColor = .black
    }
    
}
