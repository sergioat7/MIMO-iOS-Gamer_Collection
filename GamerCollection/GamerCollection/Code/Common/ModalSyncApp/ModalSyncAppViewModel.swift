//
//  ModalSyncAppViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 24/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalSyncAppViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
    func viewDidLoad()
}

class ModalSyncAppViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:ModalSyncAppViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: ModalSyncAppDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:ModalSyncAppViewProtocol,
         dataManager: ModalSyncAppDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
        super.init(view: view)
    }
    
    // MARK: - Private functions
    
    private func manageError(error: ErrorResponse) {

        view?.hideLoading()
        view?.showError(message: error.error, handler: nil)
    }
    
    private func syncApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.view?.closePopup()
        })
    }
}

extension ModalSyncAppViewModel: ModalSyncAppViewModelProtocol {
    
    func viewDidLoad() {
        syncApp()
    }
}

