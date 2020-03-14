//
//  SagasViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020. All rights reserved.
//

import UIKit

protocol SagasViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    
}

protocol SagasConfigurableViewProtocol: class {

    func set(viewModel: SagasViewModelProtocol)
    
}

class SagasViewController: BaseViewController {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    private var viewModel:SagasViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SAGAS".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
}

// MARK: - SagasViewProtocol

extension SagasViewController:  SagasViewProtocol {
    
}

// MARK: - SagasViewProtocol

extension SagasViewController:  SagasConfigurableViewProtocol {
    
    func set(viewModel: SagasViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
