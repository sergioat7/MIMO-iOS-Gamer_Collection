//
//  FormatResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 20/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

typealias FormatsResponse = [FormatResponse]

struct FormatResponse: Codable, Hashable {
    let id: String
    let name: String
    
    // MARK: - Hashable protocol
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FormatResponse, rhs: FormatResponse) -> Bool {
        return lhs.id == rhs.id
    }
}
