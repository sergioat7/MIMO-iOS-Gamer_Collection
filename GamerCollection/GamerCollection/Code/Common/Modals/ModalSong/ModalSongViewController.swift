//
//  ModalSongViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 06/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalSongViewProtocol: BaseModalViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    
}

protocol ModalSongConfigurableViewProtocol: class {
    
    func set(viewModel: ModalSongViewModelProtocol)
    
}

class ModalSongViewController: BaseModalViewController {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    private var viewModel:ModalSongViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
        viewModel?.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: Any) {
        closePopup(success: {})
    }
    
    @IBAction func save(_ sender: Any) {
        closePopup(success: {})
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configViews() {
    }
    
}

// MARK: - ModalSongViewProtocol

extension ModalSongViewController:  ModalSongViewProtocol {
    
}

// MARK: - ModalSongViewProtocol

extension ModalSongViewController:  ModalSongConfigurableViewProtocol {
    
    func set(viewModel: ModalSongViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
