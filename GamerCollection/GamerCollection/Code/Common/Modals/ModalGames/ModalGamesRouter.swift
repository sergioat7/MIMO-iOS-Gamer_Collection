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
                                                                             dataManager: dataManager,
                                                                             gameIds: gameIds,
                                                                             handler: handler)
            controller.set(viewModel: viewModel)
            return controller
        }
        return ModalGamesViewController()
    }
    
    private var dataManager: ModalGamesDataManagerProtocol {
        return ModalGamesDataManager(gameRepository: gameRepository,
                                     platformRepository: platformRepository,
                                     stateRepository: stateRepository)
    }
    
    private var gameRepository: GameRepository {
        return GameRepository()
    }
    
    private var platformRepository: PlatformRepository {
        return PlatformRepository()
    }
    
    private var stateRepository: StateRepository {
        return StateRepository()
    }
    
    // MARK: - Initialization
    
    private let gameIds: [Int64]
    private let handler: (([Int64]?) -> Void)?
    
    init (gameIds: [Int64],
          handler: (([Int64]?) -> Void)?) {
        self.gameIds = gameIds
        self.handler = handler
    }
    
    // MARK: - Presentation Methods

    func push() {
        push(viewController: view)
    }
    
}

