//
//  GameDetailRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 25/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class GameDetailRouter: BaseRouter {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private var view:GameDetailViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "GameDetailView", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "GameDetail") as? GameDetailViewController {
            let viewModel: GameDetailViewModelProtocol = GameDetailViewModel(view: controller,
                                                                             dataManager: dataManager)
            controller.set(viewModel: viewModel)
            return controller
        }
        return GameDetailViewController()
    }
    
    private var dataManager: GameDetailDataManagerProtocol {
        return GameDetailDataManager(apiClient: apiClient,
                                     gameRepository: gameRepository,
                                     formatRepository: formatRepository,
                                     genreRepository: genreRepository,
                                     platformRepository: platformRepository,
                                     stateRepository: stateRepository,
                                     songRepository: songRepository,
                                     gameId: gameId)
    }
    
    private var apiClient: GameDetailApiClientProtocol {
        return GameDetailApiClient(userManager: userManager)
    }
    
    private var userManager: UserManager {
        return UserManager()
    }
    
    private var gameRepository: GameRepository {
        return GameRepository()
    }
    
    private var formatRepository: FormatRepository {
        return FormatRepository()
    }
    
    private var genreRepository: GenreRepository {
        return GenreRepository()
    }
    
    private var platformRepository: PlatformRepository {
        return PlatformRepository()
    }
    
    private var stateRepository: StateRepository {
        return StateRepository()
    }
    
    private var songRepository: SongRepository {
        return SongRepository()
    }
    
    // MARK: - Initialization
    
    private let gameId: Int64?
    
    init (gameId: Int64?) {
        self.gameId = gameId
    }
    
    // MARK: - Presentation Methods

    func push() {
        push(viewController: view)
    }
    
}

