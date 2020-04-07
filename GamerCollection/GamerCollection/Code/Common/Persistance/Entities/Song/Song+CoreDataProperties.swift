//
//  Song+CoreDataProperties.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 07/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//
//

import Foundation
import CoreData


extension Song {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
        return NSFetchRequest<Song>(entityName: Song.entityName)
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var singer: String?
    @NSManaged public var url: String?
    @NSManaged public var game: Game?

}
