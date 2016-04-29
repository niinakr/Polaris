//
//  MapViewController.swift
//  PolarisApp
//
//  Created by iosdev on 20.4.2016.
//  Copyright © 2016 Niina Kristiina. All rights reserved.
//

import Foundation

class MapViewController {

func drawMap() {
    
let myClassroom = EILLocationBuilder()
    
myClassroom.setLocationName("My Classroom")
    
    myClassroom.setLocationBoundaryPoints([
        EILPoint(x: 0.00, y: 0.00),
        EILPoint(x: 0.00, y: 09.00),
        EILPoint(x: 09.00, y: 09.00),
        EILPoint(x: 09.00, y: 0.00)])
    
    myClassroom.addBeaconWithIdentifier("de0f1c1fe1e8",
        atBoundarySegmentIndex: 0, inDistance: 4.5, fromSide: .LeftSide)
    myClassroom.addBeaconWithIdentifier("f0d9c4f70527",
        atBoundarySegmentIndex: 1, inDistance: 4.5, fromSide: .RightSide)
    myClassroom.addBeaconWithIdentifier("e2208d08b720",
        atBoundarySegmentIndex: 2, inDistance: 4.5, fromSide: .LeftSide)
    myClassroom.addBeaconWithIdentifier("ce59e89bd34e",
        atBoundarySegmentIndex: 3, inDistance: 4.5, fromSide: .RightSide)
    
    myClassroom.setLocationOrientation(50)
    
    let location = myClassroom.build()
    
    ESTConfig.setupAppID("polarisapp-jdk", andAppToken: "42a557a97b7838d4741205f03705c1de")
    let addLocationRequest = EILRequestAddLocation(location: location!)
    addLocationRequest.sendRequestWithCompletion { (location, error) in
        if error != nil {
            NSLog("Error when saving location: \(error)")
        } else {
            NSLog("Location saved successfully: \(location!.identifier)")
        }
    }
    }

    
    
    
}
