//
//  CoreDataRepositoryProtocol.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 20/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import CoreData

protocol CoreDataRepositoryProtocol {
    
    associatedtype K
    associatedtype M
    associatedtype R
    
    var entityName: String { get }
    
    func get(id: K, success: @escaping (M?) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func getAll(success: @escaping ([M]) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func insert(item: M, success: @escaping (R) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func update(item: M, success: @escaping (R) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func delete(id: K, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void)
    func deleteAll(success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void)
    func execute(predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]?, success: @escaping ([M], [R]) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

extension CoreDataRepositoryProtocol {
    
    func get(id: K,
             success: @escaping (M?) -> Void,
             failure: @escaping (ErrorResponse) -> Void) {
        
        let managedContext = CoreDataStack.shared.managedObjectContext
        managedContext.performAndWait {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
            request.predicate = self.getPredicate(id: id)
            
            do {
                guard let results = try managedContext.fetch(request) as? [NSManagedObject],
                    let result = results.first else {
                    self.handleError(failure: failure)
                    return
                }
                
                self.transformToModel(results: [result], success: { models in
                    success(models.first)
                }, failure: failure)
            } catch {
                self.handleError(failure: failure)
            }
        }
    }
    
    func getAll(success: @escaping ([M]) -> Void,
                failure: @escaping (ErrorResponse) -> Void) {
        
        let managedContext = CoreDataStack.shared.managedObjectContext
        managedContext.performAndWait {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
            
            do {
                guard let results = try managedContext.fetch(request) as? [NSManagedObject] else {
                    self.handleError(failure: failure)
                    return
                }
                
                self.transformToModel(results: results, success: { models in
                    success(models)
                }, failure: failure)
            } catch {
                self.handleError(failure: failure)
            }
        }
    }
    
    func delete(id: K,
                success: @escaping () -> Void,
                failure: @escaping (ErrorResponse) -> Void) {
        
        let managedContext = CoreDataStack.shared.managedObjectContext
        managedContext.performAndWait {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
            request.predicate = self.getPredicate(id: id)
            
            do {
                guard let results = try managedContext.fetch(request) as? [NSManagedObject],
                    let result = results.first else {
                    self.handleError(failure: failure)
                    return
                }
                
                managedContext.delete(result)
                
                try managedContext.save()
                success()
            } catch {
                self.handleError(failure: failure)
            }
        }
    }
    
    func deleteAll(success: @escaping () -> Void,
                   failure: @escaping (ErrorResponse) -> Void) {
        
        let managedContext = CoreDataStack.shared.managedObjectContext
        managedContext.performAndWait {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
            
            do {
                guard let results = try managedContext.fetch(request) as? [NSManagedObject] else {
                    self.handleError(failure: failure)
                    return
                }
                
                for result in results {
                    managedContext.delete(result)
                }
                
                try managedContext.save()
                success()
            } catch {
                self.handleError(failure: failure)
            }
        }
    }
    
    func execute(predicate: NSPredicate,
                 sortDescriptors: [NSSortDescriptor]?,
                 success: @escaping ([M], [R]) -> Void,
                 failure: @escaping (ErrorResponse) -> Void) {
        
        let managedContext = CoreDataStack.shared.managedObjectContext
        managedContext.performAndWait {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
            request.predicate = predicate
            request.sortDescriptors = sortDescriptors
            
            do {
                guard let results = try managedContext.fetch(request) as? [NSManagedObject] else {
                    self.handleError(failure: failure)
                    return
                }
                
                self.transformToModel(results: results, success: { models in
                    
                    let records = results.compactMap({ $0 as? R })
                    success(models, records)
                }, failure: failure)
            } catch {
                self.handleError(failure: failure)
            }
        }
    }
    
    
    // MARK: - Private functions
    
    private func getPredicate(id: K) -> NSPredicate {
        
        var predicate: NSPredicate
        switch id {
        case is Int64:
            predicate = NSPredicate(format: "id = %ld", id as! Int64)
        case is String:
            predicate = NSPredicate(format: "id = %ld", id as! String)
        default:
            predicate = NSPredicate(value: true)
        }
        return predicate
    }
    
    private func transformToModel(results: [NSManagedObject],
                                  success: @escaping ([M]) -> Void,
                                  failure: @escaping (ErrorResponse) -> Void) {
        
        let resultsModelConvertible = results.compactMap({ $0 as? ModelHandlerProtocol })
        var resultsModel = [M]()
        for result in resultsModelConvertible {
            result.getModel(success: { response in
                resultsModel.append(response)
            }, failure: failure)
        }
        
        success(resultsModel)
    }
    
    private func handleError(failure: @escaping (ErrorResponse) -> Void) {
        
        let error = ErrorResponse(error: "ERROR_CORE_DATA")
        failure(error)
    }
}
