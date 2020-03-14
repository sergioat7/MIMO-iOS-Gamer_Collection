//
//  GamesViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020. All rights reserved.
//

import UIKit

protocol GamesViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    
}

protocol GamesConfigurableViewProtocol: class {

    func set(viewModel: GamesViewModelProtocol)
    
}

class GamesViewController: BaseViewController {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    private var viewModel:GamesViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "GAMES".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
}

// MARK: - GamesViewProtocol

extension GamesViewController:  GamesViewProtocol {
    
}

// MARK: - GamesViewProtocol

extension GamesViewController:  GamesConfigurableViewProtocol {
    
    func set(viewModel: GamesViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
