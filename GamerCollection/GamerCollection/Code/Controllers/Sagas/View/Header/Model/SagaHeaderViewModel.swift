//
//  SagaHeaderViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class SagaHeaderViewModel {
    
    private let saga: SagaResponse
    
    init(saga: SagaResponse) {
        self.saga = saga
    }
    
    var id: Int64 {
        get {
            return saga.id
        }
    }
    
    var name: String? {
        get {
            return saga.name
        }
    }
}
