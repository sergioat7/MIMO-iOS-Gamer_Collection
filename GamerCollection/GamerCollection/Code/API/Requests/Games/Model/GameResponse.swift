//
//  GameResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 21/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

typealias GamesResponse = [GameResponse]

struct GameResponse: Codable, Hashable {
    let id: Int64
    let name: String?
    let platform: String?
    let score: Double
    let pegi: String?
    let distributor: String?
    let developer: String?
    let players: String?
    let releaseDate: String?
    let goty: Bool
    let format: String?
    let genre: String?
    let state: String?
    let purchaseDate: String?
    let purchaseLocation: String?
    let price: Double
    let imageUrl: String?
    let videoUrl: String?
    let loanedTo: String?
    let observations: String?
    var saga: SagaResponse?
    let songs: SongsResponse
    
    // MARK: - Hashable protocol
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: GameResponse, rhs: GameResponse) -> Bool {
        return lhs.id == rhs.id
    }
}
