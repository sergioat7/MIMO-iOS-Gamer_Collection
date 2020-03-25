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
    
    // MARK: - Private functions
    
    private func manageError(error: ErrorResponse) {

        view?.hideLoading()
        view?.showError(message: error.error, handler: nil)
    }
    
    private func getContent() {
        
        view?.showLoading()
        dataManager.getGame(success: { gameResponse in
            self.dataManager.getFormats(success: { formatsResponse in
                self.dataManager.getGenres(success: { genresResponse in
                    self.dataManager.getPlatforms(success: { platformsResponse in
                        self.dataManager.getStates(success: { statesResponse in
                            
                            self.view?.hideLoading()
                        }, failure: { error in
                            self.manageError(error: error)
                        })
                    }, failure: { error in
                        self.manageError(error: error)
                    })
                }, failure: { error in
                    self.manageError(error: error)
                })
            }, failure: { error in
                self.manageError(error: error)
            })
        }, failure: { error in
            self.manageError(error: error)
        })
    }
    
    @objc private func editGame() {
        print("edit")
    }
}

extension GameDetailViewModel: GameDetailViewModelProtocol {
    
    func viewDidLoad() {
        
        editHandler = #selector(editGame)
        showNavBarButtons()
        getContent()
    }
}

