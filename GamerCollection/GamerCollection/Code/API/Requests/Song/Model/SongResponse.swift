//
//  SongResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 06/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

typealias SongsResponse = [SongResponse]

struct SongResponse: Codable, Hashable {
    let id: Int64
    let name: String?
    let singer: String?
    let url: String?
    
    // MARK: - Hashable protocol
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: SongResponse, rhs: SongResponse) -> Bool {
        return lhs.id == rhs.id
    }
}
