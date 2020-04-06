//
//  ModalSyncAppViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 24/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalSyncAppViewProtocol: BaseModalViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
}

protocol ModalSyncAppConfigurableViewProtocol: class {
    
    func set(viewModel: ModalSyncAppViewModelProtocol)
    
}

class ModalSyncAppViewController: BaseModalViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var lbTitle: UILabel!
    
    // MARK: - Private properties
    
    private var viewModel:ModalSyncAppViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configLabel()
        viewModel?.viewDidLoad()
    }
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configLabel() {
        lbTitle.attributedText = NSAttributedString(string: "SYNC_TITLE".localized(),
                                                    attributes: [.font: UIFont.bold18,
                                                                 .foregroundColor: Color.color1])
    }
}

// MARK: - ModalSyncAppViewProtocol

extension ModalSyncAppViewController:  ModalSyncAppViewProtocol {
}

// MARK: - ModalSyncAppViewProtocol

extension ModalSyncAppViewController:  ModalSyncAppConfigurableViewProtocol {
    
    func set(viewModel: ModalSyncAppViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
