//
//  SagasViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol SagasViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
    func viewDidLoad()
    func viewWillAppear()
    func getSagaHeaderViewModels() -> [SagaHeaderViewModel]
    func getSagaGameCellViewModels(sagaId: Int64) -> [GameCellViewModel]
}

class SagasViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:SagasViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: SagasDataManagerProtocol
    private var sagaHeaderViewModels: [SagaHeaderViewModel] = []
    private var gameCellViewModels: [GameCellViewModel] = []
    
    // MARK: - Initialization
    
    init(view:SagasViewProtocol,
         dataManager: SagasDataManagerProtocol) {
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
        dataManager.getSagas(success: { sagas in
            self.dataManager.getGames(sagas: sagas, success: { games in
                self.dataManager.getPlatforms(success: { platforms in
                    self.dataManager.getStates(success: { states in
                        
                        self.sagaHeaderViewModels = sagas.compactMap({return SagaHeaderViewModel(saga: $0)})
                        self.gameCellViewModels = games.compactMap({ game -> GameCellViewModel in
                            let platform = platforms.first(where: { $0.id == game.platform })
                            let state = states.first(where: { $0.id == game.state })
                            return GameCellViewModel(game: game,
                                                     platform: platform,
                                                     state: state)
                        })
                        self.view?.showSagas()
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
    
    @objc private func addSaga() {
        SagaDetailRouter(sagaId: nil).push()
    }
}

extension SagasViewModel: SagasViewModelProtocol {

    func viewDidLoad() {
        
        addHandler = #selector(addSaga)
        showNavBarButtons()
    }
    
    func viewWillAppear() {
        getContent()
    }
    
    func getSagaHeaderViewModels() -> [SagaHeaderViewModel] {
        return sagaHeaderViewModels
    }
    
    func getSagaGameCellViewModels(sagaId: Int64) -> [GameCellViewModel] {
        
        let sagaGameCellViewModels = gameCellViewModels.filter({ $0.sagaId == sagaId })
        return sagaGameCellViewModels
    }
}

