//
//  GameDetailViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 25/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol GameDetailViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
    func viewDidLoad()
}

class GameDetailViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:GameDetailViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: GameDetailDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:GameDetailViewProtocol,
         dataManager: GameDetailDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
        super.init(view: view)
    }
}

extension GameDetailViewModel: GameDetailViewModelProtocol {
    
    func viewDidLoad() {
        
    }
}

