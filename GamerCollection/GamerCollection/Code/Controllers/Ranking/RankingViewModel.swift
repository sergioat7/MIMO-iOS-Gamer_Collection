//
//  RankingViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol RankingViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
     func viewDidLoad()
     func viewWillAppear()
     func getGameCellViewModels() -> [GameCellViewModel]
}

class RankingViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:RankingViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: RankingDataManagerProtocol
    private var gameCellViewModels: [GameCellViewModel] = []
    private var filters: FiltersModel?
    
    // MARK: - Initialization
    
    init(view:RankingViewProtocol,
         dataManager: RankingDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
        super.init(view: view)
    }
    
    // MARK: - Private functions
    
    private func manageError(error: ErrorResponse) {

        view?.hideLoading()
        view?.showError(message: error.error, handler: nil)
    }
    
    private func getContent(filters: FiltersModel?, success: @escaping ([GameCellViewModel]) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        view?.showLoading()
        dataManager.getGames(filters: filters, success: { games in
            self.dataManager.getPlatforms(success: { platforms in
                self.dataManager.getStates(success: { states in
                    
                    let gameCellViewModels = games.compactMap({ game -> GameCellViewModel in
                        
                        let platform = platforms.first(where: { $0.id == game.platform })
                        let state = states.first(where: { $0.id == game.state })
                        return GameCellViewModel(game: game,
                                                 platform: platform,
                                                 state: state)
                    })
                    success(gameCellViewModels)
                }, failure: failure)
            }, failure: failure)
        }, failure: failure)
    }
    
    @objc private func filterGames() {
        
        let viewControllerToPresent = ModalFilterRouter(handler: applyFilters,
                                                        filters: filters).view
        view?.showPopup(viewControllerToPresent: viewControllerToPresent)
    }
    
    private func applyFilters(filters: FiltersModel?) {
        
        self.filters = filters
        getContent(filters: filters, success: { gameCellViewModels in
            
            self.gameCellViewModels = gameCellViewModels
            self.view?.showGames()
            self.view?.hideLoading()
        }, failure: { error in
            self.manageError(error: error)
        })
    }
}

extension RankingViewModel: RankingViewModelProtocol {
    
    func viewDidLoad() {
        
        filterHandler = #selector(filterGames)
        showNavBarButtons()
    }
    
    func viewWillAppear() {
        
        getContent(filters: filters, success: { gameCellViewModels in
            
            self.gameCellViewModels = gameCellViewModels
            self.view?.showGames()
            self.view?.hideLoading()
        }, failure: { error in
            self.manageError(error: error)
        })
    }
    
    func getGameCellViewModels() -> [GameCellViewModel] {
        return gameCellViewModels
    }
}

