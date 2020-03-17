//
//  UserProfileViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 16/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol UserProfileViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    func seTextFields(username: String, password: String)
}

protocol UserProfileConfigurableViewProtocol: class {
    
    func set(viewModel: UserProfileViewModelProtocol)
    
}

class UserProfileViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btSave: ActionButton!
    @IBOutlet weak var btDelete: ActionButton!
    
    // MARK: - Private properties
    
    private var viewModel:UserProfileViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "PROFILE".localized()
        configViews()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.removeGestureRecognizers()
    }
    
    // MARK: - Actions
    
    @IBAction func update() {
        
        let password = tfPassword.text ?? ""
        hideKeyboard()
        viewModel?.updatePassword(password: password)
    }
    
    @IBAction func delete() {
        
        showConfirmationDialog(message: "PROFILE_DELETE_CONFIRMATION".localized(), handler: {
            self.viewModel?.deleteUser()
        }, handlerCancel: nil)
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configViews() {
        
        tfPassword.delegate = self
        tfUsername.placeholder = "REGISTRATION_USERNAME".localized()
        tfPassword.placeholder = "REGISTRATION_PASSWORD".localized()
        
        btSave.background = Color.color3
        btSave.text = Color.color2
        btDelete.background = Color.color4
        btDelete.text = Color.color2
    }
    
    @objc private func hideKeyboard() {
        tfPassword.resignFirstResponder()
    }
    
}

// MARK: - UserProfileViewProtocol

extension UserProfileViewController:  UserProfileViewProtocol {
    
    func seTextFields(username: String, password: String) {
        
        tfUsername.text = username
        tfPassword.text = password
    }
}

// MARK: - UserProfileViewProtocol

extension UserProfileViewController:  UserProfileConfigurableViewProtocol {
    
    func set(viewModel: UserProfileViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}

// MARK: - UITextFieldDelegate

extension UserProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case tfPassword:
            update()
        default:break
        }
        return true
    }
}
