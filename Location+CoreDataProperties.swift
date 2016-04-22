//
//  Location+CoreDataProperties.swift
//  
//
//  Created by iosdev on 22.4.2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {

    @NSManaged var favourite: NSNumber?
    @NSManaged var name: String?
    @NSManaged var type: String?
    @NSManaged var x: NSNumber?
    @NSManaged var y: NSNumber?
    @NSManaged var locationBeacon: Beacons?
    @NSManaged var locationFavourite: Favourites?
    @NSManaged var locationRoom: Room?
    @NSManaged var locationTarget: Target?

}
