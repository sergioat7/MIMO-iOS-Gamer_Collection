//
//  Platform+CoreDataProperties.swift
//  GamerCollection
//
//  Created by alumno on 20/03/2020.
//
//

import Foundation
import CoreData


extension Platform {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Platform> {
        return NSFetchRequest<Platform>(entityName: "Platform")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
