//
//  ViewController.swift
//  PolarisApp
//
//  Created by Niina Kristiina on 08/04/16.
//  Copyright © 2016 Niina Kristiina. All rights reserved.
//

import UIKit
import MapKit
import CoreData


class ViewController: UIViewController, UISearchBarDelegate, EILIndoorLocationManagerDelegate {
    
    
    
    @IBOutlet weak var searchView: UISearchBar!
    
    var favourite:Favourites?
    let locationManager = EILIndoorLocationManager()
    var location: EILLocation!
    var currentPosition : EILOrientedPoint!
    var navigationLayer: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self

        ESTConfig.setupAppID("polarisapp-jdk", andAppToken: "42a557a97b7838d4741205f03705c1de")
        
        let fetchLocationRequest = EILRequestFetchLocation(locationIdentifier: "my-classroom")
        fetchLocationRequest.sendRequestWithCompletion { (location, error) in
            if let location = location {
                self.location = location
                self.locationView.backgroundColor = UIColor.clearColor()
                self.locationView.showTrace = false
                self.locationView.traceColor = UIColor.brownColor()
                self.locationView.rotateOnPositionUpdate = false
                self.locationView.locationBorderColor = UIColor.darkGrayColor()
                self.locationView.locationBorderThickness = 3
                self.locationView.drawLocation(location) //draw your location
                
                self.locationManager.startPositionUpdatesForLocation(self.location)
            } else {
                print("can't fetch location: \(error)")
            }
        }
        
        if let s = favourite {
            
            searchView.text = s.favouriteName
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:Selector("dismissKeyboard"))
        view.addGestureRecognizer(tap)
        //// Do any additional setup after loading the view, typically from a nib.
        
        //add rooms as core data
        
        //reference to appDelegate
        //        let appdel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        //        //reference to context
        //        let context: NSManagedObjectContext = appdel.managedObjectContext
        //        // save data from beacons
        //        let newroom1 = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: context) as NSManagedObject
        //        newroom1.setValue("test1", forKey: "roomName")
        //        newroom1.setValue("2222", forKey: "beaconUUID")
        //        let newroom2 = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: context) as NSManagedObject
        //        newroom2.setValue("test2", forKey: "roomName")
        //        newroom2.setValue("3333", forKey: "beaconUUID")
        //
        //
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var locationView: EILIndoorLocationView!
    
    func indoorLocationManager(manager: EILIndoorLocationManager, didFailToUpdatePositionWithError error: NSError) {
            print("failed to update position: \(error)")
    }
    
    
    func updateNavigation() {
        var path = UIBezierPath()
        let newPoint = locationView.calculatePicturePointFromRealPoint(currentPosition)
        path.moveToPoint(newPoint)
        let newPoint2 = locationView.calculatePicturePointFromRealPoint(EILOrientedPoint(x: 1.5, y: 1.5, orientation: 0))
        // x and y coordintion start from the lowest left corner of the map view
        path.addLineToPoint(CGPoint(x: newPoint2.x, y: newPoint.y))
        path.addLineToPoint(newPoint2)
        if navigationLayer != nil {
            navigationLayer.removeFromSuperlayer()
        }
        //        navigationLayer.removeFromSuperlayer()
        navigationLayer = CAShapeLayer()
        navigationLayer.path = path.CGPath
        navigationLayer.strokeColor = UIColor.blackColor().CGColor
        navigationLayer.fillColor = UIColor.clearColor().CGColor
        navigationLayer.lineDashPattern = [3,4]
        locationView.layer.insertSublayer(navigationLayer, atIndex: 0)
    }
    
    func indoorLocationManager(manager: EILIndoorLocationManager,
        didUpdatePosition position: EILOrientedPoint,
        withAccuracy positionAccuracy: EILPositionAccuracy,
        inLocation location: EILLocation) {
            var accuracy: String!
            switch positionAccuracy {
            case .VeryHigh: accuracy = "+/- 1.00m"
            case .High:     accuracy = "+/- 1.62m"
            case .Medium:   accuracy = "+/- 2.62m"
            case .Low:      accuracy = "+/- 4.24m"
            case .VeryLow:  accuracy = "+/- ? :-("
            case .Unknown:  accuracy = "unknown"
            }
            print(String(format: "x: %5.2f, y: %5.2f, orientation: %3.0f, accuracy: %@", position.x, position.y, position.orientation, accuracy))
            currentPosition = position
            self.locationView.updatePosition(position)
            updateNavigation()
    }
    

    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let searchroom = searchView.text!
        self.filtterrooms(searchroom)
    }
    
    
    func filtterrooms(searchtext: String) {
        
        
        //reference to appDelegate
        let appdel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        //reference to context
        let context: NSManagedObjectContext = appdel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Room")
        request.returnsObjectsAsFaults = false;
        
        let predicate = NSPredicate(format: "roomName contains %@",searchtext)
        request.predicate = predicate
        
        do {
            let result: NSArray =  try context.executeFetchRequest(request)
            if (result.count > 0) {
                for res in result {
                    print(res)
                }
            }
            else {
                print("0 results returned")
            }
        } catch{
        }
        
    }
    
    @IBAction func selfPosition(sender: AnyObject) {
    print("position button pressed")
        
    }
    
    @IBAction func displayrooms(sender: AnyObject) {
        print("displayrooms button pressed")
        
        //reference to appDelegate
        let appdel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        
        //reference to context
        let context: NSManagedObjectContext = appdel.managedObjectContext
        
        
        //Display the information from beacons
        let request = NSFetchRequest(entityName: "Room")
        request.returnsObjectsAsFaults = false;
        
        do {
            let result: NSArray =  try context.executeFetchRequest(request)
            if (result.count > 0) {
                for res in result {
                    print(res)
                }
            }
            else {
                print("0 results returned")
            }
        } catch{}
        
    }

    
    @IBAction func displayfavourites() {
        
        //reference to appDelegate
        let appdel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        //reference to context
        let context: NSManagedObjectContext = appdel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Favourites")
        request.returnsObjectsAsFaults = false;
        
        do {
        let result: NSArray =  try context.executeFetchRequest(request)
            if (result.count > 0) {
                for res in result {
                    print(res)
                }
            }
            else {
                print("0 results returned")
            }
        } catch{
        }
    }
    
    @IBAction func addasfavourite() {
        
        //reference to appDelegate
        let appdel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        //reference to context
        let context: NSManagedObjectContext = appdel.managedObjectContext
        
        if (("" + searchView.text! != "Searching room name") && ("" + searchView.text! != "")) {
        do {
            
            let newfavourite = NSEntityDescription.insertNewObjectForEntityForName("Favourites", inManagedObjectContext: context) as NSManagedObject
            newfavourite.setValue("" + searchView.text!, forKey: "favouriteName")

            try context.save()
//            let a = UIAlertView(title: "Success", message: "Your favourite place is saved", delegate: nil, cancelButtonTitle: "OK")
//            a.show()
            
            let a = UIAlertController(title: "Success", message: "Your favourite place is saved", preferredStyle: UIAlertControllerStyle.Alert)
            a.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(a, animated: true, completion: nil)
            print(newfavourite)
            
        } catch {}
        }
        else {
//            let b = UIAlertView(title: "Failed", message: "Type first something", delegate: nil, cancelButtonTitle: "OK")
//            b.show()
            
            let b = UIAlertController(title: "Failed", message: "Type first something", preferredStyle: UIAlertControllerStyle.Alert)
            b.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(b, animated: true, completion: nil)

        }
    }
    
    
    //    @IBAction func displaybeacons(sender: AnyObject) {
    //        print("displaybeacons button pressed")
    //        //reference to appDelegate
    //        let appdel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    //        //reference to context
    //        let context: NSManagedObjectContext = appdel.managedObjectContext
    //        // save data from beacons
    //        let newbeacon1 = NSEntityDescription.insertNewObjectForEntityForName("Beacons", inManagedObjectContext: context) as NSManagedObject
    //        newbeacon1.setValue("1881818jdjd89383", forKey: "id")
    //        newbeacon1.setValue("2222", forKey: "major")
    //        newbeacon1.setValue("1111", forKey: "minor")
    //        newbeacon1.setValue("test", forKey: "name")
    //
    //        let newbeacon2 = NSEntityDescription.insertNewObjectForEntityForName("Beacons", inManagedObjectContext: context) as NSManagedObject
    //        newbeacon2.setValue("1881818j22289383", forKey: "id")
    //        newbeacon2.setValue("3333", forKey: "major")
    //        newbeacon2.setValue("4444", forKey: "minor")
    //        newbeacon2.setValue("test2", forKey: "name")
    
    //Display the information from beacons
    //        let request = NSFetchRequest(entityName: "Beacons")
    //        request.returnsObjectsAsFaults = false;
    //        do {
    //            let result: NSArray =  try context.executeFetchRequest(request)
    //            if (result.count > 0) {
    //                for res in result {
    //                    print(res)
    //                }
    //            }
    //            else {
    //                print("0 results returned")
    //            }
    //        } catch{}
    //    }

}

