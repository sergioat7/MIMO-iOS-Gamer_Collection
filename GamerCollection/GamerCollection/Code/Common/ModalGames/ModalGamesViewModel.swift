//
//  ModalGamesViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalGamesViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
     func viewDidLoad()
     func getHandler() -> (([Int64]?) -> Void)?
     func getGameCellViewModels() -> [GameCellViewModel]
}

class ModalGamesViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:ModalGamesViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: ModalGamesDataManagerProtocol
    private let gameIds: [Int64]
    private let handler: (([Int64]?) -> Void)?
    private var gameCellViewModels: [GameCellViewModel] = []
    
    // MARK: - Initialization
    
    init(view:ModalGamesViewProtocol,
         dataManager: ModalGamesDataManagerProtocol,
         gameIds: [Int64],
         handler: (([Int64]?) -> Void)?) {
        self.view = view
        self.dataManager = dataManager
        self.gameIds = gameIds
        self.handler = handler
        super.init(view: view)
    }
    
    // MARK: - Private functions
    
    private func manageError(error: ErrorResponse) {

        view?.hideLoading()
        view?.showError(message: error.error, handler: nil)
    }
    
    private func getContent() {
        
        view?.showLoading()
        dataManager.getGames(success: { games in
            self.dataManager.getPlatforms(success: { platforms in
                self.dataManager.getStates(success: { states in
                    
                    let gameCellViewModels = games.compactMap({ game -> GameCellViewModel in
                        
                        let platform = platforms.first(where: { $0.id == game.platform })
                        let state = states.first(where: { $0.id == game.state })
                        return GameCellViewModel(game: game,
                                                 platform: platform,
                                                 state: state,
                                                 selectable: true)
                    })
                    gameCellViewModels.forEach({ $0.isSelected = self.gameIds.contains($0.id) })
                    self.gameCellViewModels = gameCellViewModels
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
    }
}

extension ModalGamesViewModel: ModalGamesViewModelProtocol {
    
    func viewDidLoad() {
        getContent()
    }
    
    func getHandler() -> (([Int64]?) -> Void)? {
        return handler
    }
    
    func getGameCellViewModels() -> [GameCellViewModel] {
        return gameCellViewModels
    }
}

