//
//  Room+CoreDataProperties.swift
//  
//
//  Created by Niina Kristiina on 28/04/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Room {

    @NSManaged var beacon: String?
    @NSManaged var name: String?
    @NSManaged var x: NSNumber?
    @NSManaged var y: NSNumber?
    @NSManaged var room_Beacon: Beacons?
    @NSManaged var room_Teacher: NSManagedObject?

}
