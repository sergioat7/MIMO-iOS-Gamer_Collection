//
//  SagasViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020. All rights reserved.
//

import UIKit

protocol SagasViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
}

class SagasViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:SagasViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: SagasDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:SagasViewProtocol,
         dataManager: SagasDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
}

extension SagasViewModel: SagasViewModelProtocol {
    
}

