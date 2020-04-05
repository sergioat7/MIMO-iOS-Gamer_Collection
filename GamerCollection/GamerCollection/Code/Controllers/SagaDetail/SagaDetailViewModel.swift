//
//  SagaDetailViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol SagaDetailViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
    func viewDidLoad()
}

class SagaDetailViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:SagaDetailViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: SagaDetailDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:SagaDetailViewProtocol,
         dataManager: SagaDetailDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
        super.init(view: view)
    }
}

extension SagaDetailViewModel: SagaDetailViewModelProtocol {
    
    func viewDidLoad() {
        
    }
}

