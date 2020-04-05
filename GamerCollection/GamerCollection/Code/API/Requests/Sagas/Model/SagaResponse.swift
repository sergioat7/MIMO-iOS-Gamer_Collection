//
//  SagaResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 04/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

typealias SagasResponse = [SagaResponse]

struct SagaResponse: Codable {
    let id: Int64
    let name: String?
    var games: GamesResponse
}
