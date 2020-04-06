//
//  FiltersModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 01/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

struct FiltersModel {
    let platforms: [String]
    let genres: [String]
    let formats: [String]
    let minScore: Double
    let maxScore: Double
    let minReleaseDate: Date?
    let maxReleaseDate: Date?
    let minPurchaseDate: Date?
    let maxPurchaseDate: Date?
    let minPrice: Double
    let maxPrice: Double
    let isGoty: Bool
    let isLoaned: Bool
    let hasSaga: Bool
    let hasSongs: Bool
}
