//
//  ModalSongRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 06/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class ModalSongRouter: BaseRouter {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    var view:ModalSongViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "ModalSongView", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "ModalSong") as? ModalSongViewController {
            let viewModel: ModalSongViewModelProtocol = ModalSongViewModel(view: controller,
                                                                           dataManager: dataManager)
            controller.set(viewModel: viewModel)
            return controller
        }
        return ModalSongViewController()
    }
    
    private var dataManager: ModalSongDataManagerProtocol {
        return ModalSongDataManager(apiClient: apiClient)
    }
    
    private var apiClient: ModalSongApiClientProtocol {
        return ModalSongApiClient()
    }
    
    // MARK: - Initialization
    
    override init() {}
    
    // MARK: - Presentation Methods

    func push() {
        push(viewController: view)
    }
    
}

