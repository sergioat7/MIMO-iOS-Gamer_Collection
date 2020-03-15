//
//  LoginViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol LoginViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    func setUsernameTextField(username: String)
}

protocol LoginConfigurableViewProtocol: class {

    func set(viewModel: LoginViewModelProtocol)
    
}

class LoginViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btLogin: ActionButton!
    @IBOutlet weak var btRegister: UIButton!
    
    // MARK: - Private properties
    
    private var viewModel:LoginViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIViewController.hideNavigationBar(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIViewController.hideNavigationBar(false, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Actions
    
    @IBAction func login() {
        
        tfPassword.resignFirstResponder()
        let username = tfUsername.text ?? ""
        let password = tfPassword.text ?? ""
        viewModel?.login(username: username, password: password)
    }
    
    @IBAction func register() {
        print("register")
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configViews() {
        
        tfUsername.delegate = self
        tfPassword.delegate = self
        tfUsername.placeholder = "LOGIN_USERNAME".localized()
        tfPassword.placeholder = "LOGIN_PASSWORD".localized()
        
        btLogin.background = Color.color3
        btLogin.text = Color.color2
        
        let text1 = "LOGIN_NOT_ACCOUNT".localized()
        let text2 = "LOGIN_REGISTER".localized()
        let totalText = "\(text1)\(text2)"
        let attributedString = NSMutableAttributedString(string: totalText,
                                                         attributes: [.foregroundColor : Color.color2])
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Color.color5, range: NSRange(location: text1.count, length: text2.count))
        btRegister.setAttributedTitle(attributedString, for: UIControl.State())
    }
    
}

// MARK: - LoginViewProtocol

extension LoginViewController: LoginViewProtocol {
    
    func setUsernameTextField(username: String) {
        tfUsername.text = username
    }
}

// MARK: - LoginViewProtocol

extension LoginViewController: LoginConfigurableViewProtocol {
    
    func set(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case tfUsername:
            tfPassword.becomeFirstResponder()
        case tfPassword:
            login()
        default:break
        }
        return true
    }
    
    
}
