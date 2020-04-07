//
//  BaseModalViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 06/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol BaseModalViewProtocol: BaseViewProtocol {
    func closePopup(success: @escaping () -> Void)
}

class BaseModalViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.animatedDarkenBackground()
        }
    }
    
    func closePopup(success: @escaping () -> Void) {
        
        animatedClearBackground()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hidePopup()
            success()
        }
    }
    
    //MARK: - Private functions
    
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
