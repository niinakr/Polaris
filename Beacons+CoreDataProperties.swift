//
//  Beacons+CoreDataProperties.swift
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

extension Beacons {

    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var major: String?
    @NSManaged var minor: String?

}
