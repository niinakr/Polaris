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
    
    @IBOutlet weak var Menu: UIBarButtonItem!
  
    
    @IBOutlet weak var myLocationView: EILIndoorLocationView!
    
    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var Avatar_name: UILabel!
    
//    var toPass:String!
//    
    var favourite:Favourites?
    
   

    
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
        
        let predicate = NSPredicate(format: "name contains %@",searchtext)
        request.predicate = predicate
        
        
        do {
            let result: NSArray =  try context.executeFetchRequest(request)
            if (result.count > 0) {
                for res in result {
                    var thisroom = res as! Room
                    searchView.text = thisroom.name
                    print(res)
                }
            }
            else {
                searchView.text = "no results found"
                print("0 results returned")
            }
        } catch{}
        

        
    }
   
//    @IBAction func selfPosition(sender: AnyObject) {
//    print("position button pressed")
////        positionLabel.text = (" Your Location")
////       
////        positionLabel.text = NSString(format: "x: %.2f, y: %.2f, a: %.2f",
////        position.x,
////        position.y)
////    
//        
//    }
    
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

        
    
    
//    @IBAction func displaybeacons(sender: AnyObject) {
//        print("displaybeacons button pressed")
//        
//        
//        //reference to appDelegate
//        let appdel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//
//        
//        //reference to context
//        let context: NSManagedObjectContext = appdel.managedObjectContext
//        
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
//        
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
//        
//    }
    
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
        } catch{}
        
        
    }
    
    @IBAction func addasfavourite() {
        

        
        //reference to appDelegate
        let appdel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        //reference to context
        let context: NSManagedObjectContext = appdel.managedObjectContext
        
        if (("" + searchView.text! != "Searching room name") && ("" + searchView.text! != "")) {
        do {
            
            let newfavourite = NSEntityDescription.insertNewObjectForEntityForName("Favourites", inManagedObjectContext: context) as NSManagedObject
            newfavourite.setValue("" + searchView.text!, forKey: "favouriteplace")

//            let newfavourite = EILPositionView.actionForLayer(NSEntityDescription.insertNewObjectForEntityForName("Favourites", inManagedObjectContext: context)) as NSManagedObject
//            newfavourite.setValue("" + searchView.text!, forKey: "favouriteplace")
            try context.save()
            let a = UIAlertView(title: "Success", message: "Your favourite place is saved", delegate: nil, cancelButtonTitle: "OK")
            a.show()
            print(newfavourite)
        } catch {}
        }
        else {
            let b = UIAlertView(title: "Failed", message: "Type first something", delegate: nil, cancelButtonTitle: "OK")
            b.show()

            
        }
        

    }
    
    let locationManager = EILIndoorLocationManager()
    var location: EILLocation!
    //var myMap = MapViewController()
    
    
    @IBOutlet weak var locationView: EILIndoorLocationView!
    
    func indoorLocationManager(manager: EILIndoorLocationManager,
        didFailToUpdatePositionWithError error: NSError) {
            print("failed to update position: \(error)")
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
             positionLabel.text =  NSString(format: "x: %5.2f, y: %5.2f, orientation: %3.0f, accuracy: %@",
                position.x, position.y, position.orientation, accuracy) as String
        

            self.locationView.updatePosition(position)
    }
    
    
    func getCurrentAvatar()-> User {
         print("getCurrentAvatar() function")
        let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let req = NSFetchRequest(entityName: "User")
    
        do {
            let fetchedResults = try moContext.executeFetchRequest(req)
            if fetchedResults.count == 0 {
                print("fetchedResults is == 0")
                let newavatar2 = NSEntityDescription.insertNewObjectForEntityForName("User",inManagedObjectContext: moContext) as NSManagedObject
                newavatar2.setValue("kukkuu", forKey: "avatar_name")
                try moContext.save()
                print(newavatar2)

            }
            print("fetchedResults[ 0 ]")
            return fetchedResults[(fetchedResults.count)-1] as! User
        } catch let error as NSError {
            print(error.localizedDescription)
            return User()
        }
    }
    
    func Addrooms()-> Room {

        
        print("testing room")
        let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let req = NSFetchRequest(entityName: "Room")
        
        do {
            let fetchedResults = try moContext.executeFetchRequest(req)
            if fetchedResults.count == 0 {
                let newroom1 = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: moContext) as NSManagedObject
                        newroom1.setValue("ETYB 303", forKey: "name")
                        newroom1.setValue("22", forKey: "x")
                        newroom1.setValue("11", forKey: "y")
                
                
                    let newroom2 = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: moContext) as NSManagedObject
                        newroom2.setValue("ETYB 304", forKey: "name")
                        newroom2.setValue("33", forKey: "x")
                        newroom2.setValue("44", forKey: "y")
                
                    let newroom3 = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: moContext) as NSManagedObject
                        newroom3.setValue("Meeting room", forKey: "name")
                        newroom3.setValue("33", forKey: "x")
                        newroom3.setValue("44", forKey: "y")
                
                    let newroom4 = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: moContext) as NSManagedObject
                        newroom4.setValue("Teacher office", forKey: "name")
                        newroom4.setValue("33", forKey: "x")
                        newroom4.setValue("44", forKey: "y")
                
                //                Display the information from beacons
                        let request = NSFetchRequest(entityName: "Room")
                        try moContext.save()
                        request.returnsObjectsAsFaults = false;
                        print("Added all information from rooms")
                
                do {
                                let result: NSArray =  try moContext.executeFetchRequest(request)
                                if (result.count > 0) {
                                    for res in result {
                                        print(res)
                                    }
                                }
                                else {
                                    print("0 results returned")
                                }
                            } catch{}            }
            
            return fetchedResults[2] as! Room
        } catch let error as NSError {
            print("error")
            print(error.localizedDescription)
            return Room()
        }
    
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // update label with avatar name
        let user:User = getCurrentAvatar()
        Avatar_name.text = user.avatar_name
        Addrooms()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    
        
        Menu.target = self.revealViewController()
        Menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        self.locationManager.delegate = self
        
        //myMap.drawMap()
        
        ESTConfig.setupAppID("polarisapp-jdk", andAppToken: "42a557a97b7838d4741205f03705c1de")
        
        let fetchLocationRequest = EILRequestFetchLocation(locationIdentifier: "my-classroom")
        fetchLocationRequest.sendRequestWithCompletion { (location, error) in
            if location != nil {
                self.location = location!
               // self.locationView.showTrace = true
                self.locationView.rotateOnPositionUpdate = false
                
                
                self.locationView.drawLocation(location!)
                
                self.locationManager.startPositionUpdatesForLocation(self.location)
            } else {
                print("can't fetch location: \(error)")
            }
        }
    
        
        if let s = favourite {
            
            searchView.text = s.favouriteplace
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
        
        //add rooms as core data
        
        //reference to appDelegate
//        let appdel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        
//        
//        //reference to context
//        let context: NSManagedObjectContext = appdel.managedObjectContext
//        
//        // save data from beacons
//        let newroom1 = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: context) as NSManagedObject
//        newroom1.setValue("test1", forKey: "roomName")
//        newroom1.setValue("2222", forKey: "beaconUUID")
//        
//        
//        let newroom2 = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: context) as NSManagedObject
//        newroom2.setValue("test2", forKey: "roomName")
//        newroom2.setValue("3333", forKey: "beaconUUID")
//        
    
//  
//        Avatar_name.text = toPass
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
    
    //pass the avatarseque from menubar_register
    
       
    
}

