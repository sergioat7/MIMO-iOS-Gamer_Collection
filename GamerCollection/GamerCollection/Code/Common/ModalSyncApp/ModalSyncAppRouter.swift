//
//  ModalSyncAppRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 24/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class ModalSyncAppRouter: BaseRouter {
    
    // MARK: - Public variables
    
    var view:ModalSyncAppViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "ModalSyncAppView", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "ModalSyncApp") as? ModalSyncAppViewController {
            let viewModel: ModalSyncAppViewModelProtocol = ModalSyncAppViewModel(view: controller,
                                                                                 dataManager: dataManager)
            controller.set(viewModel: viewModel)
            return controller
        }
        return ModalSyncAppViewController()
    }
    
    // MARK: - Private variables
    
    private var dataManager: ModalSyncAppDataManagerProtocol {
        return ModalSyncAppDataManager()
    }
    
    // MARK: - Initialization
    
    override init() {}
    
    // MARK: - Presentation Methods

    func push() {
        push(viewController: view)
    }
    
}

