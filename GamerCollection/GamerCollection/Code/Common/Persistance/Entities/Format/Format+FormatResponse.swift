//
//  Format+FormatResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 20/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import CoreData

extension Format: ModelHandlerProtocol {
    
    func storeEntity<M, R>(item: M,
                           context: NSManagedObjectContext,
                           success: @escaping (R) -> Void,
                           failure: @escaping (ErrorResponse) -> Void) {
        
        guard let item = item as? FormatResponse else {
            let error = ErrorResponse(error: "ERROR_CORE_DATA")
            failure(error)
            return
        }
        
        id = item.id
        name = item.name
        
        do {
            try CoreDataStack.shared.saveContext(context)
        } catch {
            let error = ErrorResponse(error: "ERROR_CORE_DATA")
            failure(error)
        }
        
        guard let format = self as? R else {
            let error = ErrorResponse(error: "ERROR_CORE_DATA")
            failure(error)
            return
        }
        
        success(format)
    }
    
    func getModel<M>(success: @escaping (M) -> Void,
                     failure: @escaping (ErrorResponse) -> Void) {
        
        guard let id = id,
            let name = name else {
                let error = ErrorResponse(error: "ERROR_CORE_DATA")
                failure(error)
                return
        }
        
        guard let formatResponse = FormatResponse(id: id,
                                                  name: name) as? M else {
                                                    let error = ErrorResponse(error: "ERROR_CORE_DATA")
                                                    failure(error)
                                                    return
        }
        
        success(formatResponse)
    }
}
