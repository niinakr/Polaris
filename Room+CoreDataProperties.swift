//
//  Room+CoreDataProperties.swift
//  PolarisApp
//
//  Created by Niina Kristiina on 20/04/16.
//  Copyright © 2016 Niina Kristiina. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Room {

    @NSManaged var beaconUUID: String?
    @NSManaged var roomName: String?
    @NSManaged var room_Beacon: Beacons?
    @NSManaged var room_Teacher: NSManagedObject?

}
