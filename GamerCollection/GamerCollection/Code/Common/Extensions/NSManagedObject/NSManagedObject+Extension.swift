//
//  NSManagedObject+Extension.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 20/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import CoreData

extension NSManagedObject: Managed {}

protocol Managed: class {
    static var entityName: String { get }
}

extension Managed where Self: NSManagedObject {
    static var entityName: String { return entity().name! }
}
