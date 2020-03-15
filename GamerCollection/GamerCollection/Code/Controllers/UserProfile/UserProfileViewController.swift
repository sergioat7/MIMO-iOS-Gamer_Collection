//
//  UserProfileViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol UserProfileViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    
}

protocol UserProfileConfigurableViewProtocol: class {
    
    func set(viewModel: UserProfileViewModelProtocol)
    
}

class UserProfileViewController: BaseViewController {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    private var viewModel:UserProfileViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PROFILE".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
}

// MARK: - UserProfileViewProtocol

extension UserProfileViewController:  UserProfileViewProtocol {
    
}

// MARK: - UserProfileViewProtocol

extension UserProfileViewController:  UserProfileConfigurableViewProtocol {
    
    func set(viewModel: UserProfileViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
