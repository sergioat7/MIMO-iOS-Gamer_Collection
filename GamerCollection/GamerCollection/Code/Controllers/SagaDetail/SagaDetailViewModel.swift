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
    func showGamesModal()
    func deleteSaga()
}

class SagaDetailViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:SagaDetailViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: SagaDetailDataManagerProtocol
    private var saga: SagaResponse?
    private var newGames = GamesResponse()
    
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
                
                self.saga = saga
                self.saga?.games = games
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
    
    @objc private func editGame() {
        
        view?.enableEdition(enable: true)
        showSaveButton()
        showCancelButton()
    }
    
    @objc private func saveGame() {
        
        view?.showLoading()
        if let sagaId = dataManager.getSagaId() {
            
            let sagaName = view?.getSagaName()
            let saga = SagaResponse(id: sagaId,
                                    name: sagaName,
                                    games: newGames)
            self.dataManager.setSaga(saga: saga, success: { sagaResponse in
                
                self.saga = sagaResponse
                self.view?.enableEdition(enable: false)
                self.showNavBarButtons()
                self.view?.showBackbarButtonItem()
                self.view?.setName(name: sagaResponse.name)
                self.view?.showGames(games: sagaResponse.games)
                self.view?.hideLoading()
            }, failure: { error in
                self.manageError(error: error)
            })
        } else {
            
            let sagaName = view?.getSagaName()
            let saga = SagaResponse(id: 0,
                                    name: sagaName,
                                    games: newGames)
            dataManager.createSaga(saga: saga, success: {
                self.dataManager.updateSagas(success: {
                    
                    self.view?.hideLoading()
                    self.view?.popViewController()
                }, failure: { error in
                    self.manageError(error: error)
                })
            }, failure: { error in
                self.manageError(error: error)
            })
        }
    }
    
    @objc private func cancelEdition() {
        
        view?.enableEdition(enable: false)
        showNavBarButtons()
        view?.showBackbarButtonItem()
        view?.setName(name: saga?.name)
        view?.showGames(games: saga?.games ?? GamesResponse())
    }
    
    private func addGames(gameIds: [Int64]?) {
        
        if let gameIds = gameIds {
            
            view?.showLoading()
            dataManager.getSelectedGames(gameIds: gameIds, success: { games in
                
                self.newGames = games
                self.view?.showGames(games: games)
                self.view?.hideLoading()
            }, failure: { error in
                self.manageError(error: error)
            })
        }
    }
}

extension SagaDetailViewModel: SagaDetailViewModelProtocol {
    
    func viewDidLoad() {
        
        editHandler = #selector(editGame)
        cancelHandler = #selector(cancelEdition)
        saveHandler = #selector(saveGame)
        
        if dataManager.getSagaId() != nil {
            showNavBarButtons()
            view?.enableEdition(enable: false)
        } else {
            showSaveButton()
            view?.enableEdition(enable: true)
        }

        getContent()
    }
    
    func showGamesModal() {
        
        let gameIds = saga?.games.compactMap({$0.id}) ?? []
        let viewControllerToPresent = ModalGamesRouter(gameIds: gameIds,
                                                       handler: addGames).view
        view?.showPopup(viewControllerToPresent: viewControllerToPresent)
    }
    
    func deleteSaga() {
        
        view?.showLoading()
        dataManager.deleteSaga(success: {
            
            self.view?.hideLoading()
            self.view?.popViewController()
        }, failure: { error in
            self.manageError(error: error)
        })
    }
}

