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
    
    // MARK: - Private functions
    
    private func manageError(error: ErrorResponse) {

        view?.hideLoading()
        view?.showError(message: error.error, handler: nil)
    }
    
    private func getContent() {
        
        view?.showLoading()
        dataManager.getSaga(success: { saga in
            self.dataManager.getGames(success: { games in
                
                self.view?.setName(name: saga?.name)
                self.view?.showGames(games: games)
                self.view?.hideLoading()
            }, failure: { error in
                self.manageError(error: error)
            })
        }, failure: { error in
            self.manageError(error: error)
        })
    }
}

extension SagaDetailViewModel: SagaDetailViewModelProtocol {
    
    func viewDidLoad() {
        getContent()
    }
}

