//
//  Target+CoreDataProperties.swift
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

extension Target {

    @NSManaged var beaconUUID: String?
    @NSManaged var email: String?
    @NSManaged var gender: String?
    @NSManaged var name: String?
    @NSManaged var type: String?
    @NSManaged var targetLocation: Location?

}
