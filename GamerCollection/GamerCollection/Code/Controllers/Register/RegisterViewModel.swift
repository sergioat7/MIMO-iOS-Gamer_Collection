//
//  RegisterViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 15/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol RegisterViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
}

class RegisterViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:RegisterViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: RegisterDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:RegisterViewProtocol,
         dataManager: RegisterDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
}

extension RegisterViewModel: RegisterViewModelProtocol {
    
}

