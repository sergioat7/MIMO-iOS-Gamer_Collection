//
//  GenreResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 20/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

typealias GenresResponse = [GenreResponse]

struct GenreResponse: Codable, Hashable {
    let id: String
    let name: String
    
    // MARK: - Hashable protocol
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: GenreResponse, rhs: GenreResponse) -> Bool {
        return lhs.id == rhs.id
    }
}
