//
//  Genre+CoreDataProperties.swift
//  GamerCollection
//
//  Created by alumno on 20/03/2020.
//
//

import Foundation
import CoreData


extension Genre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
