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
    func showAddSongModal()
    func removeSong(songId: Int64)
    func deleteGame()
}

class GameDetailViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:GameDetailViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: GameDetailDataManagerProtocol
    
    private var game: GameResponse?
    
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
                            
                            self.game = gameResponse
                            self.view?.showPlatforms(platforms: platformsResponse)
                            self.view?.showGenres(genres: genresResponse)
                            self.view?.showFormats(formats: formatsResponse)
                            self.view?.showStates(states: statesResponse)
                            self.view?.showData(game: gameResponse)
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
        
        view?.enableEdition(enable: true)
        showSaveButton()
        showCancelButton()
    }
    
    @objc private func saveGame() {
        
        if let gameData = view?.getGameData() {
            
            view?.showLoading()
            
            if dataManager.getGameId() != nil {
                
                dataManager.setGame(game: gameData, success: { gameResponse in
                    
                    self.game = gameResponse
                    self.view?.enableEdition(enable: false)
                    self.showNavBarButtons()
                    self.view?.showBackbarButtonItem()
                    self.view?.showData(game: gameResponse)
                    self.view?.hideLoading()
                }, failure: { error in
                    self.manageError(error: error)
                })
            } else {
                
                dataManager.createGame(game: gameData, success: {
                    self.dataManager.updateGames(success: {
                        
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
    }
    
    @objc private func cancelEdition() {
        
        view?.enableEdition(enable: false)
        showNavBarButtons()
        view?.showBackbarButtonItem()
        view?.showData(game: game)
    }
    
    private func updateData() {
        
        view?.showLoading()
        dataManager.updateGame(success: {
            self.dataManager.getGame(success: { gameResponse in

                self.game = gameResponse
                self.view?.showData(game: gameResponse)
                self.view?.enableEdition(enable: true)
                self.view?.hideLoading()
            }, failure: { error in
                self.manageError(error: error)
            })
        }, failure: { error in
            self.manageError(error: error)
        })
    }
}

extension GameDetailViewModel: GameDetailViewModelProtocol {
    
    func viewDidLoad() {
        
        editHandler = #selector(editGame)
        cancelHandler = #selector(cancelEdition)
        saveHandler = #selector(saveGame)
        
        if dataManager.getGameId() != nil {
            showNavBarButtons()
            view?.enableEdition(enable: false)
        } else {
            showSaveButton()
            view?.enableEdition(enable: true)
        }

        getContent()
    }
    
    func showAddSongModal() {
        
        if let gameId = dataManager.getGameId() {
            let viewControllerToPresent = ModalSongRouter(gameId: gameId,
                                                          handler: updateData).view
            view?.showPopup(viewControllerToPresent: viewControllerToPresent)
        }
    }
    
    
    func removeSong(songId: Int64) {
        
        view?.showLoading()
        dataManager.deleteSong(songId: songId, success: {
            
            self.view?.hideLoading()
            self.updateData()
        }, failure: { error in
            self.manageError(error: error)
        })
    }
    
    func deleteGame() {
        
        view?.showLoading()
        dataManager.deleteGame(success: {
            
            self.view?.hideLoading()
            self.view?.popViewController()
        }, failure: { error in
            self.manageError(error: error)
        })
    }
}

