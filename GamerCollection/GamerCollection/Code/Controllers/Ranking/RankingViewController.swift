//
//  RankingViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol RankingViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    
}

protocol RankingConfigurableViewProtocol: class {
    
    func set(viewModel: RankingViewModelProtocol)
    
}

class RankingViewController: BaseViewController {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    private var viewModel:RankingViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "RANKING".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
}

// MARK: - RankingViewProtocol

extension RankingViewController:  RankingViewProtocol {
    
}

// MARK: - RankingViewProtocol

extension RankingViewController:  RankingConfigurableViewProtocol {
    
    func set(viewModel: RankingViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
