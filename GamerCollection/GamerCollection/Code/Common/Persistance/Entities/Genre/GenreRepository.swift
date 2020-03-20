//
//  GenreRepository.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 20/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import CoreData

class GenreRepository: CoreDataRepositoryProtocol {
        
    typealias K = String
    typealias M = GenreResponse
    typealias R = Genre
    
    var entityName: String { return R.entityName }
    
    func insert(item: M, success: @escaping (R) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        get(id: item.id, success: { model in
            
            guard model != nil else {

                let managedContext = CoreDataStack.shared.managedObjectContext
                managedContext.performAndWait {
                    
                    guard let entityDescription = NSEntityDescription.entity(forEntityName: R.entityName, in: managedContext),
                        let managedObject = NSManagedObject(entity: entityDescription, insertInto: managedContext) as? R else {
                            self.handleError(failure: failure)
                            return
                    }
                    
                    managedObject.storeEntity(item: item,
                                              context: managedContext,
                                              success: success,
                                              failure: failure)
                }
                return
            }
            
            self.handleError(failure: failure)
        }, failure: failure)
    }
    
    func update(item: M, success: @escaping (R) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        getRecords(success: { records in
            
            guard let record = records.compactMap({ $0 as? R }).first(where: { $0.id == item.id }) else {
                self.insert(item: item,
                            success: success,
                            failure: failure)
                return
            }
            
            let managedContext = CoreDataStack.shared.managedObjectContext
            managedContext.performAndWait {
                record.storeEntity(item: item,
                                   context: managedContext,
                                   success: success,
                                   failure: failure)
            }
        }, failure: failure)
    }
    
}
