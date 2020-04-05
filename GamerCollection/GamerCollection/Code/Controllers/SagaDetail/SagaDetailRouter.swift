//
//  SagaDetailRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class SagaDetailRouter: BaseRouter {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private var view:SagaDetailViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "SagaDetailView", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "SagaDetail") as? SagaDetailViewController {
            let viewModel: SagaDetailViewModelProtocol = SagaDetailViewModel(view: controller,
                                                                             dataManager: dataManager)
            controller.set(viewModel: viewModel)
            return controller
        }
        return SagaDetailViewController()
    }
    
    private var dataManager: SagaDetailDataManagerProtocol {
        return SagaDetailDataManager(apiClient: apiClient,
                                     gameRepository: gameRepository,
                                     sagaRepository: sagaRepository,
                                     sagaId: sagaId)
    }
    
    private var apiClient: SagaDetailApiClientProtocol {
        return SagaDetailApiClient()
    }
    
    private var gameRepository: GameRepository {
        return GameRepository()
    }
    
    private var sagaRepository: SagaRepository {
        return SagaRepository()
    }
    
    // MARK: - Initialization
    
    private let sagaId: Int64?
    
    init (sagaId: Int64?) {
        self.sagaId = sagaId
    }
    
    // MARK: - Presentation Methods

    func push() {
        push(viewController: view)
    }
    
}

