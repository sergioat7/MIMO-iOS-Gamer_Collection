//
//  Saga+CoreDataProperties.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 04/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//
//

import Foundation
import CoreData


extension Saga {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Saga> {
        return NSFetchRequest<Saga>(entityName: Saga.entityName)
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var games: NSSet?

}

// MARK: Generated accessors for games
extension Saga {

    @objc(addGamesObject:)
    @NSManaged public func addToGames(_ value: Game)

    @objc(removeGamesObject:)
    @NSManaged public func removeFromGames(_ value: Game)

    @objc(addGames:)
    @NSManaged public func addToGames(_ values: NSSet)

    @objc(removeGames:)
    @NSManaged public func removeFromGames(_ values: NSSet)

}
