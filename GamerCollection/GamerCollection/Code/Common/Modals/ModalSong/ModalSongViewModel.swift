//
//  ModalSongViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 06/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalSongViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
    func createSong(song: SongResponse)
}

class ModalSongViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:ModalSongViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: ModalSongDataManagerProtocol
    private let handler: (() -> Void)?
    
    // MARK: - Initialization
    
    init(view:ModalSongViewProtocol,
         dataManager: ModalSongDataManagerProtocol,
         handler: (() -> Void)?) {
        self.view = view
        self.dataManager = dataManager
        self.handler = handler
        super.init(view: view)
    }
    
    // MARK: - Private functions
    
    private func manageError(error: ErrorResponse) {

        view?.hideLoading()
        view?.showError(message: error.error, handler: nil)
    }
}

extension ModalSongViewModel: ModalSongViewModelProtocol {
    
    func createSong(song: SongResponse) {
        
        view?.showLoading()
        dataManager.createSong(song: song, success: {
            
            self.view?.hideLoading()
            self.view?.closePopup(success: {
                self.handler?()
            })
        }, failure: { error in
            self.manageError(error: error)
        })
    }
}

