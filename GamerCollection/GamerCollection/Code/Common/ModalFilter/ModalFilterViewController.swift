//
//  ModalFilterViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 29/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalFilterViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    func closePopup()
}

protocol ModalFilterConfigurableViewProtocol: class {
    
    func set(viewModel: ModalFilterViewModelProtocol)
    
}

class ModalFilterViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var svFilters: UIScrollView!
    
    // MARK: - Private properties
    
    private var viewModel:ModalFilterViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        scrollView = svFilters
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerKeyboardNotifications()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.animatedDarkenBackground()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardNotifications()
        view.removeGestureRecognizers()
    }
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: Any) {
        closePopup()
    }
    
    @IBAction func reset(_ sender: Any) {
    }
    
    @IBAction func save(_ sender: Any) {
        closePopup()
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
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

// MARK: - ModalFilterViewProtocol

extension ModalFilterViewController:  ModalFilterViewProtocol {
    
    func closePopup() {
        
        animatedClearBackground()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hidePopup()
        }
    }
    
}

// MARK: - ModalFilterViewProtocol

extension ModalFilterViewController:  ModalFilterConfigurableViewProtocol {
    
    func set(viewModel: ModalFilterViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
