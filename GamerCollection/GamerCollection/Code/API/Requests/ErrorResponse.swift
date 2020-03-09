//
//  ErrorResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 09/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

struct ErrorResponse {
    let error: Error?
    let errorString = "ERROR_SERVER".localized()
}
