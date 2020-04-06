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
        view?.showError(message: error.error, handler: {
            self.view?.closePopup(success: {})
        })
    }
    
    private func syncApp() {
        
        var errorResponse: ErrorResponse?
        let group = DispatchGroup()
        
        group.enter()
        dataManager.getFormats(success: { _ in
            self.dataManager.getGenres(success: { _ in
                self.dataManager.getPlatforms(success: { _ in
                    self.dataManager.getStates(success: { _ in
                        self.dataManager.getGames(success: { _ in
                            self.dataManager.getSagas(success: { _ in
                                group.leave()
                            }, failure: { error in
                                errorResponse = error
                                group.leave()
                            })
                        }, failure: { error in
                            errorResponse = error
                            group.leave()
                        })
                    }, failure: { error in
                        errorResponse = error
                        group.leave()
                    })
                }, failure: { error in
                    errorResponse = error
                    group.leave()
                })
            }, failure: { error in
                errorResponse = error
                group.leave()
            })
        }, failure: { error in
            errorResponse = error
            group.leave()
        })
        
        group.notify(queue: .main) {
            if let error = errorResponse {
                self.manageError(error: error)
            } else {
                self.view?.closePopup(success: {})
            }
            MainTabBarController.show()
        }
    }
}

extension ModalSyncAppViewModel: ModalSyncAppViewModelProtocol {
    
    func viewDidLoad() {
        syncApp()
    }
}

