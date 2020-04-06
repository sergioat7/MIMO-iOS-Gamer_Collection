//
//  ModalSongViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 06/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalSongViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    
}

protocol ModalSongConfigurableViewProtocol: class {
    
    func set(viewModel: ModalSongViewModelProtocol)
    
}

class ModalSongViewController: BaseViewController {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    private var viewModel:ModalSongViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        configViews()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.animatedDarkenBackground()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: Any) {
        closePopup()
    }
    
    @IBAction func save(_ sender: Any) {
        closePopup()
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configViews() {
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
    
    private func closePopup() {
        
        animatedClearBackground()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hidePopup()
        }
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
