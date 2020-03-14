//
//  GamesViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020. All rights reserved.
//

import UIKit

protocol GamesViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
}

class GamesViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:GamesViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: GamesDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:GamesViewProtocol,
         dataManager: GamesDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
}

extension GamesViewModel: GamesViewModelProtocol {
    
}

