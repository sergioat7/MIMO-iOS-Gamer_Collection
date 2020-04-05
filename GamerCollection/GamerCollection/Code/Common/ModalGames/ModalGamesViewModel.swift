//
//  ModalGamesViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalGamesViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
     func viewDidLoad()
}

class ModalGamesViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:ModalGamesViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: ModalGamesDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:ModalGamesViewProtocol,
         dataManager: ModalGamesDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
        super.init(view: view)
    }
}

extension ModalGamesViewModel: ModalGamesViewModelProtocol {
    
    func viewDidLoad() {
        
    }
}

