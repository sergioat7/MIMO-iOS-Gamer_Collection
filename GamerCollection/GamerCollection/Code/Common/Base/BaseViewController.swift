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
    func showConfirmationDialog(message: String, handler: (() -> Void)?, handlerCancel: (() -> Void)?)
    func showRightBarButtonItems(rightBarButtonItems: [UIBarButtonItem])
    func showLeftBarButtonItems(leftBarButtonItems: [UIBarButtonItem])
    func showBackbarButtonItem()
    func showSyncPopup(viewControllerToPresent: UIViewController)
    func showFilterPopup(viewControllerToPresent: UIViewController)
    func hidePopup()
    func registerKeyboardNotifications()
    func removeKeyboardNotifications()
    func popViewController()
    func showAlertWithTextField(handlerAccept: ((String) -> Void)?, handlerCancel: (() -> Void)?)
}

class BaseViewController: UIViewController {
    
    var loadingScreen = LoadingScreen()
    var isLoading: Bool = false
    var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.color1
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = Color.color1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let message = "Showing " + NSStringFromClass(self.classForCoder)
        print(message)
    }
    
    // MARK: - BaseViewProtocol
    
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
    
    func showConfirmationDialog(message: String, handler: (() -> Void)?, handlerCancel: (() -> Void)?) {
        
        let popup = PopupDialog(title: "app_name".localized(),
                                message: message.localized(),
                                buttonAlignment: .horizontal)
        
         setupDialog()
        
        let button = DefaultButton(title: "ACCEPT".localized(), dismissOnTap: true) {
            handler?()
        }
        
        let cancelButton = CancelButton(title: "CANCEL".localized(), dismissOnTap: true) {
            handlerCancel?()
        }
        
        popup.addButtons([button, cancelButton])
        present(popup, animated: true)
    }
    
    func showRightBarButtonItems(rightBarButtonItems: [UIBarButtonItem]) {
        navigationItem.rightBarButtonItems = rightBarButtonItems
    }
    
    func showLeftBarButtonItems(leftBarButtonItems: [UIBarButtonItem]) {
        navigationItem.leftBarButtonItems = leftBarButtonItems
    }
    
    func showBackbarButtonItem() {
        navigationItem.leftBarButtonItems = []
    }
    
    func showSyncPopup(viewControllerToPresent: UIViewController) {
        viewControllerToPresent.modalPresentationStyle = .overFullScreen
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func showFilterPopup(viewControllerToPresent: UIViewController) {
        viewControllerToPresent.modalPresentationStyle = .overFullScreen
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func hidePopup() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func registerKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    func popViewController() {
        UIViewController.getCurrentNavigationController()?.popViewController()
    }
    
    func showAlertWithTextField(handlerAccept: ((String) -> Void)?, handlerCancel: (() -> Void)?) {
        
        if presentedViewController != nil {
            dismiss(animated: true, completion: nil)
        }
        
        let title = "GAME_DETAIL_IMAGE_MODAL_TITLE".localized()
        let message = ""
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { textField in }
        
        let cancelAction = UIAlertAction(title: "CANCEL".localized(), style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "ACCEPT".localized(), style: .default) { (action) in
            var text = ""
            if let textField = alertController.textFields?.first {
                text = textField.text ?? ""
            }
            handlerAccept?(text)
            alertController.dismiss(animated: true, completion: nil)
            
        }
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Other functions
    
    @objc func hideKeyboard() {
        view.endEditing(true)
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
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView?.contentInset = .zero
        scrollView?.scrollIndicatorInsets = .zero
    }
    
}
