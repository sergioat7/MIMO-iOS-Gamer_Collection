//
//  ModalSongViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 06/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalSongViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
    func viewDidLoad()
}

class ModalSongViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:ModalSongViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: ModalSongDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:ModalSongViewProtocol,
         dataManager: ModalSongDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
        super.init(view: view)
    }
}

extension ModalSongViewModel: ModalSongViewModelProtocol {
    
    func viewDidLoad() {
        
    }
}

