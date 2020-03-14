//
//  LoginViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020. All rights reserved.
//

import UIKit

protocol LoginViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    
}

protocol LoginConfigurableViewProtocol: class {

    func set(viewModel: LoginViewModelProtocol)
    
}

class LoginViewController: BaseViewController {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    private var viewModel:LoginViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
}

// MARK: - LoginViewProtocol

extension LoginViewController:  LoginViewProtocol {
    
}

// MARK: - LoginViewProtocol

extension LoginViewController:  LoginConfigurableViewProtocol {
    
    func set(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
