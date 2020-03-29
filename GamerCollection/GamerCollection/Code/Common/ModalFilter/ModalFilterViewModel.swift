//
//  ModalFilterViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 29/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalFilterViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
    func viewDidLoad()
}

class ModalFilterViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:ModalFilterViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: ModalFilterDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:ModalFilterViewProtocol,
         dataManager: ModalFilterDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
        super.init(view: view)
    }
}

extension ModalFilterViewModel: ModalFilterViewModelProtocol {
    
    func viewDidLoad() {
        
    }
}

