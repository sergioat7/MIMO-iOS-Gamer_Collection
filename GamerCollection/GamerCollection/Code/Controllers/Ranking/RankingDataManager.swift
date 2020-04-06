//
//  RankingDataManager.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol RankingDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
     func getGames(filters: FiltersModel?, success: @escaping(GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
     func getPlatforms(success: @escaping(PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
     func getStates(success: @escaping(StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

class RankingDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let gameRepository: GameRepository
    private let platformRepository: PlatformRepository
    private let stateRepository: StateRepository
    
    // MARK: - Initialization
    
    init(gameRepository: GameRepository,
         platformRepository: PlatformRepository,
         stateRepository: StateRepository) {
        self.gameRepository = gameRepository
        self.platformRepository = platformRepository
        self.stateRepository = stateRepository
    }
}

extension RankingDataManager: RankingDataManagerProtocol {
    
    func getGames(filters: FiltersModel?, success: @escaping(GamesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        let predicate = getFilterPredicates(filters: filters)
        
        var sortDescriptors = [NSSortDescriptor]()
        sortDescriptors.append(NSSortDescriptor(key: "score", ascending: false))
        sortDescriptors.append(NSSortDescriptor(key: "name", ascending: true))
        
        gameRepository.execute(predicate: predicate,
                               sortDescriptors: sortDescriptors,
                               success: { (gameModels, _) in
                                success(gameModels)
        }, failure: failure)
    }
    
    func getPlatforms(success: @escaping(PlatformsResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        platformRepository.getAll(success: success, failure: failure)
    }
    
    func getStates(success: @escaping(StatesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        stateRepository.getAll(success: success, failure: failure)
    }
    
    // MARK: - Private functions
    
    func getFilterPredicates(filters: FiltersModel?) -> NSCompoundPredicate {
        
        var predicates = [NSPredicate]()
        
        if let filters = filters {
            
            var platformPredicates = [NSPredicate]()
            
            let platforms = filters.platforms
            if !platforms.isEmpty {
                for platform in platforms {
                    platformPredicates.append(NSPredicate(format: "platform = %@", platform))
                }
            }
            
            let genres = filters.genres
            if !genres.isEmpty {
                for genre in genres {
                    platformPredicates.append(NSPredicate(format: "genre = %@", genre))
                }
            }
            
            let formats = filters.formats
            if !formats.isEmpty {
                for format in formats {
                    platformPredicates.append(NSPredicate(format: "format = %@", format))
                }
            }
            
            if platformPredicates.count > 0 {
                predicates.append(NSCompoundPredicate(orPredicateWithSubpredicates: platformPredicates))
            }
            
            let minScore = filters.minScore
            let maxScore = filters.maxScore
            predicates.append(NSPredicate(format: "(score >= %f) AND (score <= %f)", minScore, maxScore))
            
            if let minReleaseDate = filters.minReleaseDate as NSDate? {
                predicates.append(NSPredicate(format: "releaseDate >= %@", minReleaseDate))
            }
            if let maxReleaseDate = filters.maxReleaseDate as NSDate? {
                predicates.append(NSPredicate(format: "releaseDate <= %@", maxReleaseDate))
            }
            
            if let minPurchaseDate = filters.minPurchaseDate as NSDate? {
                predicates.append(NSPredicate(format: "purchaseDate >= %@", minPurchaseDate))
            }
            if let maxPurchaseDate = filters.maxPurchaseDate as NSDate? {
                predicates.append(NSPredicate(format: "purchaseDate <= %@", maxPurchaseDate))
            }
            
            let minPrice = filters.minPrice
            let maxPrice = filters.maxPrice
            if maxPrice > 0 {
                predicates.append(NSPredicate(format: "(price >= %f) AND (price <= %f)", minPrice, maxPrice))
            }
            
            if filters.isGoty {
                predicates.append(NSPredicate(format: "goty = true"))
            }
            
            if filters.isLoaned {
                predicates.append(NSPredicate(format: "loanedTo != nil"))
            }
            
            if filters.hasSaga {
                predicates.append(NSPredicate(format: "saga != nil"))
            }
            
//            let hasSongs = filters.hasSongs
            //TODO filter by songs
        }
        
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
}

