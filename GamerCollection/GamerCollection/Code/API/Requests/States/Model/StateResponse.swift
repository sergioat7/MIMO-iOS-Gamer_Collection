//
//  StateResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 20/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

typealias StatesResponse = [StateResponse]

struct StateResponse: Codable, Hashable {
    let id: String
    let name: String
    
    // MARK: - Hashable protocol
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: StateResponse, rhs: StateResponse) -> Bool {
        return lhs.id == rhs.id
    }
}
