//
//  ModalFilterViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 29/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalFilterViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
    func viewDidLoad()
    func getHandler() -> ((FiltersModel?) -> Void)?
}

class ModalFilterViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:ModalFilterViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: ModalFilterDataManagerProtocol
    private let handler: ((FiltersModel?) -> Void)?
    private let filters: FiltersModel?
    
    // MARK: - Initialization
    
    init(view:ModalFilterViewProtocol,
         dataManager: ModalFilterDataManagerProtocol,
         handler: ((FiltersModel?) -> Void)?,
         filters: FiltersModel?) {
        self.view = view
        self.dataManager = dataManager
        self.handler = handler
        self.filters = filters
        super.init(view: view)
    }
    
    // MARK: - Private functions
    
    private func manageError(error: ErrorResponse) {

        view?.hideLoading()
        view?.showError(message: error.error, handler: nil)
    }
    
    private func getContent() {
        
        view?.showLoading()
        dataManager.getFormats(success: { formatsResponse in
            self.dataManager.getGenres(success: { genresResponse in
                self.dataManager.getPlatforms(success: { platformsResponse in
                    
                    self.view?.setFormats(formats: formatsResponse)
                    self.view?.setGenres(genres: genresResponse)
                    self.view?.setPlatforms(platforms: platformsResponse)
                    self.view?.configFilters(filters: self.filters)
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

extension ModalFilterViewModel: ModalFilterViewModelProtocol {
    
    func viewDidLoad() {
        getContent()
    }
    
    func getHandler() -> ((FiltersModel?) -> Void)? {
        return handler
    }
}

