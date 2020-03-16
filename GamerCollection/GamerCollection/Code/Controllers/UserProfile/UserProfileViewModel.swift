//
//  UserProfileViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 16/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol UserProfileViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
    func viewDidLoad()
}

class UserProfileViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:UserProfileViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: UserProfileDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:UserProfileViewProtocol,
         dataManager: UserProfileDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
        super.init(view: view)
    }
}

extension UserProfileViewModel: UserProfileViewModelProtocol {
    
    func viewDidLoad() {
        
        showNavBarButtons()
    }
}

