//
//  ModalFilterRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 29/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class ModalFilterRouter: BaseRouter {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    var view:ModalFilterViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "ModalFilterView", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "ModalFilter") as? ModalFilterViewController {
            let viewModel: ModalFilterViewModelProtocol = ModalFilterViewModel(view: controller,
                                                                               dataManager: dataManager)
            controller.set(viewModel: viewModel)
            return controller
        }
        return ModalFilterViewController()
    }
    
    private var dataManager: ModalFilterDataManagerProtocol {
        return ModalFilterDataManager(formatRepository: formatRepository,
                                      genreRepository: genreRepository,
                                      platformRepository: platformRepository)
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
    
    // MARK: - Initialization
    
    override init() {}
    
    // MARK: - Presentation Methods

    func push() {
        push(viewController: view)
    }
    
}

