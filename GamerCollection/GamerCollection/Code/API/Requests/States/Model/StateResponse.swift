//
//  StateResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 20/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

typealias StatesResponse = [StateResponse]

struct StateResponse: Codable {
    let id: String
    let name: String
}
