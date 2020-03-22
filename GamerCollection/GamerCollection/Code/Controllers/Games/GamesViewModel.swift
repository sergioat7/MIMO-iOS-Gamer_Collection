//
//  GamesViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol GamesViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
    func viewDidLoad()
    func getGameCellViewModels() -> [GameCellViewModel]
}

class GamesViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:GamesViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: GamesDataManagerProtocol
    private var gameCellViewModels: [GameCellViewModel] = []
    
    // MARK: - Initialization
    
    init(view:GamesViewProtocol,
         dataManager: GamesDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
        super.init(view: view)
    }
    
    // MARK: - Private functions
    
    private func manageError(error: ErrorResponse) {

        view?.hideLoading()
        view?.showError(message: error.error, handler: nil)
    }
}

extension GamesViewModel: GamesViewModelProtocol {
    
    func viewDidLoad() {
        
        view?.showLoading()
        dataManager.getGames(success: { games in
            self.dataManager.getFormats(success: { formats in
                self.dataManager.getPlatforms(success: { platforms in
                    self.dataManager.getStates(success: { states in
                        
                        self.gameCellViewModels = games.compactMap({ game -> GameCellViewModel in
                            
                            let format = formats.first(where: { $0.id == game.format })
                            let platform = platforms.first(where: { $0.id == game.platform })
                            let state = states.first(where: { $0.id == game.state })
                            return GameCellViewModel(game: game,
                                                     format: format,
                                                     platform: platform,
                                                     state: state)
                        })
                        self.view?.showGames()
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
    }
    
    func getGameCellViewModels() -> [GameCellViewModel] {
        return gameCellViewModels
    }
}

