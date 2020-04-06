//
//  Song+SongResponse.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 07/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import CoreData

extension Song: ModelHandlerProtocol {
    
    func storeEntity<M, R>(item: M,
                           context: NSManagedObjectContext,
                           success: @escaping (R) -> Void,
                           failure: @escaping (ErrorResponse) -> Void) {
        
        guard let item = item as? SongResponse else {
            let error = ErrorResponse(error: "ERROR_CORE_DATA")
            failure(error)
            return
        }
        
        id = item.id
        name = item.name
        singer = item.singer
        url = item.url
        
        do {
            try CoreDataStack.shared.saveContext(context)
        } catch {
            let error = ErrorResponse(error: "ERROR_CORE_DATA")
            failure(error)
        }
        
        guard let song = self as? R else {
            let error = ErrorResponse(error: "ERROR_CORE_DATA")
            failure(error)
            return
        }
        
        success(song)
    }
    
    func getModel<M>(success: @escaping (M) -> Void,
                     failure: @escaping (ErrorResponse) -> Void) {
        
        guard let songResponse = SongResponse(id: id,
                                              name: name,
                                              singer: singer,
                                              url: url) as? M else {
                                                let error = ErrorResponse(error: "ERROR_CORE_DATA")
                                                failure(error)
                                                return
        }
        
        success(songResponse)
    }
}
