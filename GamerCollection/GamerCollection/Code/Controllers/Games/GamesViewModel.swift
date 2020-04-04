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
    func viewWillAppear()
    func getGameCellViewModels() -> [GameCellViewModel]
    func filterGamesByState(showPending: Bool, showInProgress: Bool, showFinished: Bool)
}

class GamesViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:GamesViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: GamesDataManagerProtocol
    private var gameCellViewModels: [GameCellViewModel] = []
    private var state: String?
    private var filters: FiltersModel?
    
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
    
    private func getContent(state: String?, filters: FiltersModel?, success: @escaping ([GameCellViewModel]) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        view?.showLoading()
        dataManager.getGames(state: state, filters: filters, success: { games in
            self.dataManager.getFormats(success: { formats in
                self.dataManager.getPlatforms(success: { platforms in
                    self.dataManager.getStates(success: { states in
                        
                        let gameCellViewModels = games.compactMap({ game -> GameCellViewModel in
                            
                            let format = formats.first(where: { $0.id == game.format })
                            let platform = platforms.first(where: { $0.id == game.platform })
                            let state = states.first(where: { $0.id == game.state })
                            return GameCellViewModel(game: game,
                                                     format: format,
                                                     platform: platform,
                                                     state: state)
                        })
                        success(gameCellViewModels)
                    }, failure: failure)
                }, failure: failure)
            }, failure: failure)
        }, failure: failure)
    }
    
    @objc private func addGame() {
        GameDetailRouter(gameId: nil).push()
    }
    
    @objc private func filterGames() {
        
        let viewControllerToPresent = ModalFilterRouter(handler: applyFilters,
                                                        filters: filters).view
        view?.showFilterPopup(viewControllerToPresent: viewControllerToPresent)
    }
    
    private func applyFilters(filters: FiltersModel?) {
        
        self.filters = filters
        getContent(state: state, filters: filters, success: { gameCellViewModels in
            
            self.gameCellViewModels = gameCellViewModels
            self.view?.showGames()
            self.view?.setGamesCount()
            self.view?.hideLoading()
        }, failure: { error in
            self.manageError(error: error)
        })
    }
}

extension GamesViewModel: GamesViewModelProtocol {
    
    func viewDidLoad() {
        
        addHandler = #selector(addGame)
        filterHandler = #selector(filterGames)
        showNavBarButtons()
    }
    
    func viewWillAppear() {
        
        getContent(state: nil, filters: nil, success: { gameCellViewModels in
            
            self.gameCellViewModels = gameCellViewModels
            self.view?.showGames()
            self.view?.setGamesCount()
            self.view?.hideLoading()
        }, failure: { error in
            self.manageError(error: error)
        })
    }
    
    func getGameCellViewModels() -> [GameCellViewModel] {
        return gameCellViewModels
    }
    
    func filterGamesByState(showPending: Bool, showInProgress: Bool, showFinished: Bool) {
        
        if showPending {
            state = Constants.State.pending
        } else if showInProgress {
            state = Constants.State.inProgress
        } else if showFinished {
            state = Constants.State.finished
        } else {
            state = nil
        }
        
        getContent(state: state, filters: filters, success: { gameCellViewModels in
            
            self.gameCellViewModels = gameCellViewModels
            self.view?.showGames()
            self.view?.hideLoading()
        }, failure: { error in
            self.manageError(error: error)
        })
    }
}

