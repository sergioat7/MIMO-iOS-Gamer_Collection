//
//  RegisterViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 15/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol RegisterViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    
}

protocol RegisterConfigurableViewProtocol: class {
    
    func set(viewModel: RegisterViewModelProtocol)
    
}

class RegisterViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfRepeatPassword: UITextField!
    @IBOutlet weak var btRegister: ActionButton!
    
    // MARK: - Private properties
    
    private var viewModel:RegisterViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "REGISTRATION".localized()
        configViews()
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
    
    @IBAction func register() {
        
        let username = tfUsername.text ?? ""
        let password = tfPassword.text ?? ""
        let repeatPassword = tfRepeatPassword.text ?? ""
        hideKeyboard()
        viewModel?.register(username: username, password: password, repeatPassword: repeatPassword)
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configViews() {
        
        tfUsername.delegate = self
        tfPassword.delegate = self
        tfRepeatPassword.delegate = self
        tfUsername.placeholder = "REGISTRATION_USERNAME".localized()
        tfPassword.placeholder = "REGISTRATION_PASSWORD".localized()
        tfRepeatPassword.placeholder = "REGISTRATION_REPEAT_PASSWORD".localized()
        
        btRegister.background = Color.color3
        btRegister.text = Color.color2
    }
    
    @objc private func hideKeyboard() {
        
        tfUsername.resignFirstResponder()
        tfPassword.resignFirstResponder()
        tfRepeatPassword.resignFirstResponder()
    }
    
}

// MARK: - RegisterViewProtocol

extension RegisterViewController:  RegisterViewProtocol {
    
}

// MARK: - RegisterViewProtocol

extension RegisterViewController:  RegisterConfigurableViewProtocol {
    
    func set(viewModel: RegisterViewModelProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case tfUsername:
            tfPassword.becomeFirstResponder()
        case tfPassword:
            tfRepeatPassword.becomeFirstResponder()
        case tfRepeatPassword:
            register()
        default:break
        }
        return true
    }
}
