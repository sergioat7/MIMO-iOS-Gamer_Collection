//
//  GenreResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 20/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

typealias GenresResponse = [GenreResponse]

struct GenreResponse: Codable {
    let id: String
    let name: String
}
