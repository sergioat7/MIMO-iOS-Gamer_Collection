//
//  Game+CoreDataProperties.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 21/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: Game.entityName)
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var platform: String?
    @NSManaged public var score: Double
    @NSManaged public var pegi: String?
    @NSManaged public var distributor: String?
    @NSManaged public var developer: String?
    @NSManaged public var players: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var goty: Bool
    @NSManaged public var format: String?
    @NSManaged public var genre: String?
    @NSManaged public var state: String?
    @NSManaged public var purchaseDate: Date?
    @NSManaged public var purchaseLocation: String?
    @NSManaged public var price: Double
    @NSManaged public var imageUrl: String?
    @NSManaged public var videoUrl: String?
    @NSManaged public var loanedTo: String?
    @NSManaged public var observations: String?

}
