//
//  ModalFilterDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 29/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalFilterDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getGenres(success: @escaping (GenresResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getPlatforms(success: @escaping (PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class ModalFilterDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let formatRepository: FormatRepository
    private let genreRepository: GenreRepository
    private let platformRepository: PlatformRepository
    
    // MARK: - Initialization
    
    init(formatRepository: FormatRepository,
         genreRepository: GenreRepository,
         platformRepository: PlatformRepository) {
        self.formatRepository = formatRepository
        self.genreRepository = genreRepository
        self.platformRepository = platformRepository
    }
}

extension ModalFilterDataManager: ModalFilterDataManagerProtocol {
    
    func getFormats(success: @escaping (FormatsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        formatRepository.getAll(success: success, failure: failure)
    }
    
    func getGenres(success: @escaping (GenresResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        genreRepository.getAll(success: success, failure: failure)
    }
    
    func getPlatforms(success: @escaping (PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        platformRepository.getAll(success: success, failure: failure)
    }
}

