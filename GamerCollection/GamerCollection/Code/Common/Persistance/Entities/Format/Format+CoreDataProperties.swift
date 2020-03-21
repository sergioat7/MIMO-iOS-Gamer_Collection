//
//  Format+CoreDataProperties.swift
//  GamerCollection
//
//  Created by alumno on 20/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//
//

import Foundation
import CoreData


extension Format {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Format> {
        return NSFetchRequest<Format>(entityName: Format.entityName)
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
