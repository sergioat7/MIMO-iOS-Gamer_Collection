//
//  RankingViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol RankingViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
}

class RankingViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:RankingViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: RankingDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:RankingViewProtocol,
         dataManager: RankingDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
}

extension RankingViewModel: RankingViewModelProtocol {
    
}

