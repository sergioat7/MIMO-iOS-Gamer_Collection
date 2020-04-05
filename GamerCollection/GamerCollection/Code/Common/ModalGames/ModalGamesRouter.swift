//
//  ModalGamesRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class ModalGamesRouter: BaseRouter {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    var view:ModalGamesViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "ModalGamesView", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "ModalGames") as? ModalGamesViewController {
            let viewModel: ModalGamesViewModelProtocol = ModalGamesViewModel(view: controller,
                                                                             dataManager: dataManager)
            controller.set(viewModel: viewModel)
            return controller
        }
        return ModalGamesViewController()
    }
    
    private var dataManager: ModalGamesDataManagerProtocol {
        return ModalGamesDataManager()
    }
    
    // MARK: - Initialization
    
    private let handler: ((GamesResponse?) -> Void)?
    
    init (handler: ((GamesResponse?) -> Void)?) {
        self.handler = handler
    }
    
    // MARK: - Presentation Methods

    func push() {
        push(viewController: view)
    }
    
}

