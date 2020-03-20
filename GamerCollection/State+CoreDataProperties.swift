//
//  State+CoreDataProperties.swift
//  GamerCollection
//
//  Created by alumno on 20/03/2020.
//
//

import Foundation
import CoreData


extension State {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<State> {
        return NSFetchRequest<State>(entityName: "State")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
