//
//  SongResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 06/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

typealias SongsResponse = [SongResponse]

struct SongResponse: Codable {
    let id: Int64
    let name: String?
    let singer: String?
    let url: String?
}
