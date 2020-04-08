//
//  ModelHandlerProtocol.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 20/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import CoreData

protocol ModelHandlerProtocol {
    func storeEntity<M, R>(item: M, context: NSManagedObjectContext, success: @escaping (R) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getModel<M>(success: @escaping (M) -> Void, failure: @escaping (ErrorResponse) -> Void)
}
