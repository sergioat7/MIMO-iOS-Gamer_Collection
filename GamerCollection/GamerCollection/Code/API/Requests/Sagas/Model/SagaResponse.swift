//
//  SagaResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 04/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

typealias SagasResponse = [SagaResponse]

struct SagaResponse: Codable, Hashable {
    let id: Int64
    let name: String?
    var games: GamesResponse
    
    // MARK: - Hashable protocol
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: SagaResponse, rhs: SagaResponse) -> Bool {
        return lhs.id == rhs.id
    }
}
