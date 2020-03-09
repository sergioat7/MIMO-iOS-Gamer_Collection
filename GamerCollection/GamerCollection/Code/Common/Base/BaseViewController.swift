//
//  BaseViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 08/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol BaseViewProtocol: class {
    
    func showLoading()
    func hideLoading()
}

class BaseViewController: UIViewController {
    
    var loadingScreen = LoadingScreen()
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let message = "Showing " + NSStringFromClass(self.classForCoder)
        print(message)
    }
    
    func showLoading() {
        loadingScreen.show(view: view)
        isLoading = true
    }
    
    func hideLoading() {
        loadingScreen.hide(completion: nil)
        isLoading = false
    }
    
}
