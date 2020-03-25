//
//  GameDetailViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 25/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos

protocol GameDetailViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    
}

protocol GameDetailConfigurableViewProtocol: class {
    
    func set(viewModel: GameDetailViewModelProtocol)
    
}

class GameDetailViewController: BaseViewController {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    private var viewModel:GameDetailViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "GAME_DETAIL".localized()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
}

// MARK: - GameDetailViewProtocol

extension GameDetailViewController:  GameDetailViewProtocol {
    
}

// MARK: - GameDetailViewProtocol

extension GameDetailViewController:  GameDetailConfigurableViewProtocol {
    
    func set(viewModel: GameDetailViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
