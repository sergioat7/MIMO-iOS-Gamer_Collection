//
//  ModalSyncAppViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 24/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalSyncAppViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    func closePopup()
}

protocol ModalSyncAppConfigurableViewProtocol: class {
    
    func set(viewModel: ModalSyncAppViewModelProtocol)
    
}

class ModalSyncAppViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var lbTitle: UILabel!
    
    // MARK: - Private properties
    
    private var viewModel:ModalSyncAppViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        configLabel()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.animatedDarkenBackground()
        }
    }
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configLabel() {
        lbTitle.attributedText = NSAttributedString(string: "SYNC_TITLE".localized(),
                                                    attributes: [.font: UIFont.bold18,
                                                                 .foregroundColor: Color.color1])
    }
    
    private func animatedDarkenBackground() {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.view.backgroundColor = Color.color1Light
        }, completion:nil)
    }
    
    private func animatedClearBackground() {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.view.backgroundColor = UIColor.clear
        }, completion:nil)
    }
}

// MARK: - ModalSyncAppViewProtocol

extension ModalSyncAppViewController:  ModalSyncAppViewProtocol {
    
    func closePopup() {
        
        animatedClearBackground()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hidePopup()
        }
    }
}

// MARK: - ModalSyncAppViewProtocol

extension ModalSyncAppViewController:  ModalSyncAppConfigurableViewProtocol {
    
    func set(viewModel: ModalSyncAppViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
