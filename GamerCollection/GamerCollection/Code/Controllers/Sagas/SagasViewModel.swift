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
}

class SagasViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:SagasViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: SagasDataManagerProtocol
    
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
        
        
    }
    
    @objc private func addSaga() {
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
}

