//
//  PlatformResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 20/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

typealias PlatformsResponse = [PlatformResponse]

struct PlatformResponse: Codable {
    let id: String
    let name: String
}
