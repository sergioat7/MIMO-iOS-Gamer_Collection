//
//  SagaDetailViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol SagaDetailViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    
}

protocol SagaDetailConfigurableViewProtocol: class {
    
    func set(viewModel: SagaDetailViewModelProtocol)
    
}

class SagaDetailViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var tvName: UnderlinedTextView!
    @IBOutlet weak var svGames: UIStackView!
    
    // MARK: - Private properties
    
    private var viewModel:SagaDetailViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SAGA_DETAIL".localized()
        configViews()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
        view.removeGestureRecognizers()
    }
    
    // MARK: - Actions
    
    @IBAction func addGame(_ sender: Any) {
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configViews() {
        
        tvName.placeholder = "GAME_DETAIL_PLACEHOLDER_NAME".localized()
        tvName.placeholderFont = .bold24
        tvName.textFont = .bold24
        tvName.isEnabled = true
    }
}

// MARK: - SagaDetailViewProtocol

extension SagaDetailViewController:  SagaDetailViewProtocol {
    
}

// MARK: - SagaDetailViewProtocol

extension SagaDetailViewController:  SagaDetailConfigurableViewProtocol {
    
    func set(viewModel: SagaDetailViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
