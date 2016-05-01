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
    
  
    @IBOutlet weak var Menu: MyCustomButton!
    
    @IBOutlet weak var searchView: UISearchBar!
    
    //@IBOutlet weak var Menu: UIBarButtonItem!
  
    
    @IBOutlet weak var locationView: EILIndoorLocationView!
    
    
    var favourite:Favourites?
    let locationManager = EILIndoorLocationManager()
    var location: EILLocation!
    var currentPosition : EILOrientedPoint!
    var navigationLayer: CAShapeLayer!
    
    var classroomA = EILPoint(x: 4.0,y: 3.0)
    var classroomB = EILPoint(x: 6.0,y: 7.0)
    var teacherOffice = EILPoint(x: 2.0,y: 6.0)
    var meetingRoom = EILPoint(x: 2.0,y: 8.0)
    var interPoint = EILPoint(x: 6.0, y: 2.0)
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Drawing subroom
        drawSubroom()
        
        // update label with avatar name
//        let user:User = getCurrentAvatar()
//        Avatar_name.text = user.avatar_name
        
        //Adding data of rooms
        addRooms()
        
        //for swiping menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        Menu.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //get map from estimote
        self.locationManager.delegate = self
        ESTConfig.setupAppID("polarisapp-jdk", andAppToken: "42a557a97b7838d4741205f03705c1de")
        
        let fetchLocationRequest = EILRequestFetchLocation(locationIdentifier: "my-classroom")
        fetchLocationRequest.sendRequestWithCompletion { (location, error) in
            if let location = location {
                self.location = location
                self.locationView.backgroundColor = UIColor.clearColor()
                
                //Show tracing
                self.locationView.showTrace = true
                self.locationView.traceColor = UIColor.brownColor()
                self.locationView.traceThickness = 2
                
                //Config wall
                self.locationView.showWallLengthLabels = true
                //self.locationView.wallLengthLabelsColor = UIColor.blackColor()
                
                self.locationView.rotateOnPositionUpdate = false
                self.locationView.locationBorderColor = UIColor.darkGrayColor()
                self.locationView.locationBorderThickness = 3
                
                //draw your location
                self.locationView.drawLocation(location)
                self.locationManager.startPositionUpdatesForLocation(self.location)
                
                
            } else {
                print("can't fetch location: \(error)")
            }
        }
        if let s = favourite {
            
            searchView.text = s.favouriteplace
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:Selector("dismissKeyboard:"))
        view.addGestureRecognizer(tap)
    }
    
    
        //Drawing the inside wall
        func drawSubroom(){
            let view1 = UIView.init(frame: CGRect(x: 22, y: 290, width: 190, height: 5))
            view1.backgroundColor = UIColor.grayColor()
            self.view.addSubview(view1)
            
            let view2 = UIView.init(frame: CGRect(x: 260, y: 290, width: 40, height: 5))
            view2.backgroundColor = UIColor.grayColor()
            self.view.addSubview(view2)
            
            let view3 = UIView.init(frame: CGRect(x: 150, y: 150, width: 5, height: 140))
            view3.backgroundColor = UIColor.grayColor()
            self.view.addSubview(view3)
            
            let view4 = UIView.init(frame: CGRect(x: 22, y: 220, width: 130, height: 5))
            view4.backgroundColor = UIColor.grayColor()
            self.view.addSubview(view4)
        }
    
        func indoorLocationManager(manager: EILIndoorLocationManager, didFailToUpdatePositionWithError error: NSError) {
            print("failed to update position: \(error)")
        }
        
        func goToClassroomA(){
            updateNavigation(classroomA)
        }
        
        @IBAction func infoClassroomA(sender: UIButton) {
//            let text = "Course: \n Mobile Application Development \n ID: TX00CE69-3001"
//            let alert1 = UIAlertController(title: "Room ETYB304", message: text, preferredStyle: UIAlertControllerStyle.Alert)
//            alert1.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//            alert1.addAction(UIAlertAction(title: "Navigation", style: .Default, handler: { (action: UIAlertAction!) in self.goToClassroomA()
//            }))
//            self.presentViewController(alert1, animated: true, completion: nil)
            
            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
                textField.placeholder = "Enter text:"
                textField.secureTextEntry = true
            })
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        func goToClassroomB(){
            updateNavigation(classroomB)
        }
        @IBAction func infoClassroomB(sender: UIButton) {
            let text = "Course: \n Mobile Application Development \n ID: TX00CE69-3001"
            let alert1 = UIAlertController(title: "Room ETYB303", message: text, preferredStyle: UIAlertControllerStyle.Alert)
            alert1.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            alert1.addAction(UIAlertAction(title: "Navigation", style: .Default, handler: { (action: UIAlertAction!) in self.goToClassroomB()
            }))
            self.presentViewController(alert1, animated: true, completion: nil)
            
        }
        
        func goToTeacherOffice(){
            //updateNavigation(teacherOffice)
            let path = UIBezierPath()
            let startPoint = locationView.calculatePicturePointFromRealPoint(currentPosition)
            print(startPoint)
            let midPoint = locationView.calculatePicturePointFromRealPoint(interPoint)
            let endPoint = locationView.calculatePicturePointFromRealPoint(teacherOffice)
            
            // x and y coordintion start from the lowest left corner of the map view
            path.moveToPoint(startPoint)
            path.addLineToPoint(CGPoint(x: midPoint.x, y: startPoint.y))
            
            path.addLineToPoint(CGPoint(x: midPoint.x, y: endPoint.y))
            path.addLineToPoint(endPoint)
            if navigationLayer != nil {
                navigationLayer.removeFromSuperlayer()
            }
            navigationLayer = CAShapeLayer()
            navigationLayer.path = path.CGPath
            navigationLayer.strokeColor = UIColor.blackColor().CGColor
            navigationLayer.fillColor = UIColor.clearColor().CGColor
            navigationLayer.lineDashPattern = [3,4]
            locationView.layer.insertSublayer(navigationLayer, atIndex: 0)
        }
        
        @IBAction func infoTeacherOffice(sender: UIButton) {
            let text = "Course: \n Mobile Application Development \n ID: TX00CE69-3001"
            let alert1 = UIAlertController(title: "Teacher Office", message: text, preferredStyle: UIAlertControllerStyle.Alert)
            alert1.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            alert1.addAction(UIAlertAction(title: "Navigation", style: .Default, handler: { (action: UIAlertAction!) in self.goToTeacherOffice()
            }))
            self.presentViewController(alert1, animated: true, completion: nil)
            
        }
        
        func goToMeetingRoom(){
            let path = UIBezierPath()
            let startPoint = locationView.calculatePicturePointFromRealPoint(currentPosition)
            print(startPoint)
            let midPoint = locationView.calculatePicturePointFromRealPoint(interPoint)
            let endPoint = locationView.calculatePicturePointFromRealPoint(meetingRoom)
            
            // x and y coordintion start from the lowest left corner of the map view
            path.moveToPoint(startPoint)
            path.addLineToPoint(CGPoint(x: midPoint.x, y: startPoint.y))
            
            path.addLineToPoint(CGPoint(x: midPoint.x, y: endPoint.y))
            path.addLineToPoint(endPoint)
            if navigationLayer != nil {
                navigationLayer.removeFromSuperlayer()
            }
            navigationLayer = CAShapeLayer()
            navigationLayer.path = path.CGPath
            navigationLayer.strokeColor = UIColor.blackColor().CGColor
            navigationLayer.fillColor = UIColor.clearColor().CGColor
            navigationLayer.lineDashPattern = [3,4]
            locationView.layer.insertSublayer(navigationLayer, atIndex: 0)
        }
        @IBAction func infoMeetingRoom(sender: UIButton) {
            let text = "Course: \n Mobile Application Development \n ID: TX00CE69-3001"
            let alert1 = UIAlertController(title: "Meeting Room", message: text, preferredStyle: UIAlertControllerStyle.Alert)
            alert1.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            alert1.addAction(UIAlertAction(title: "Navigation", style: .Default, handler: { (action: UIAlertAction!) in self.goToMeetingRoom()
            }))
            self.presentViewController(alert1, animated: true, completion: nil)
            
        }
        
        
        func updateNavigation(destination: EILPoint) {
            let path = UIBezierPath()
            let startPoint = locationView.calculatePicturePointFromRealPoint(currentPosition)
            print(startPoint)
            path.moveToPoint(startPoint)
            //let interPoint2 = locationView.calculatePicturePointFromRealPoint(EILOrientedPoint(x: 7.0, y: startPoint.y, orientation: 0))
            let endPoint = locationView.calculatePicturePointFromRealPoint(destination)
            
            // x and y coordintion start from the lowest left corner of the map view
            path.addLineToPoint(CGPoint(x: endPoint.x, y: startPoint.y))
            path.addLineToPoint(endPoint)
            if navigationLayer != nil {
                navigationLayer.removeFromSuperlayer()
            }
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
                print(String(format: "x: %5.2f, y: %5.2f, orientation: %3.0f, accuracy: %@",
                    position.x,
                    position.y,
                    position.orientation,
                    accuracy))
                currentPosition = position
                
                self.locationView.updatePosition(position)
                
        }
    
    //Searching controller
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let searchroom = searchView.text!
        self.filtterrooms(searchroom)
    }
    
    //Searching function
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
        } catch{
        
        }
        
    }
    
    // Adding to favourite list
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
                
                let a = UIAlertController(title: "Success", message: "Your favourite place is saved", preferredStyle: UIAlertControllerStyle.Alert)
                a.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(a, animated: true, completion: nil)
                print(newfavourite)
                
            } catch {}
        }
        else {
            let b = UIAlertController(title: "Failed", message: "Type first something", preferredStyle: UIAlertControllerStyle.Alert)
            b.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(b, animated: true, completion: nil)
            
        }
    }
    
    func addRooms(){
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.managedObjectContext
        //let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let roomA = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: context) as! Room
        roomA.name = "ETYB303"
        roomA.x = 22
        roomA.y = 11
        
        let roomB = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: context) as! Room
        roomB.name = "ETYB304"
        roomB.x = 22
        roomB.y = 11
        
        let roomC = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: context) as! Room
        roomC.name = "Teacher Office"
        roomC.x = 22
        roomC.y = 11
        
        let roomD = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: context) as! Room
        roomD.name = "Meeting Room"
        roomD.x = 22
        roomD.y = 11
        
        let request = NSFetchRequest(entityName: "Room")
        try! context.save()
        print("Room: \(request.predicate)")
        
        request.returnsObjectsAsFaults = false;
        print("Added all information from rooms")
        
        var results:NSArray
        
        do{
            results = try context.executeFetchRequest(request)
            if(results.count > 0){
                for res in results{
                    print(res)
                    print(results)
                }
            } else {
                print("0 results returned")
            }
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        
    }
    
    
    
    
//    func getCurrentAvatar()-> User {
//         print("getCurrentAvatar() function")
//        let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//        let req = NSFetchRequest(entityName: "User")
//    
//        do {
//            let fetchedResults = try moContext.executeFetchRequest(req)
//            if fetchedResults.count == 0 {
//                print("fetchedResults is == 0")
//                let newavatar2 = NSEntityDescription.insertNewObjectForEntityForName("User",inManagedObjectContext: moContext) as NSManagedObject
//                newavatar2.setValue("kukkuu", forKey: "avatar_name")
//                try moContext.save()
//                print(newavatar2)
//
//            }
//            print("fetchedResults[ 0 ]")
//            return fetchedResults[(fetchedResults.count)-1] as! User
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            return User()
//        }
//    }
    
//    func Addrooms()-> Room {
//        
//        print("testing room")
//        let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//        let req = NSFetchRequest(entityName: "Room")
//        
//        do {
//            let fetchedResults = try moContext.executeFetchRequest(req)
//            if fetchedResults.count == 0 {
//                let newroom1 = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: moContext) as! Room
//                    newroom1.name = "ETYB 303"
//                    newroom1.x = 22
//                    newroom1.y = 11
//                
////                        newroom1.setValue("ETYB 303", forKey: "name")
////                        newroom1.setValue("22", forKey: "x")
////                        newroom1.setValue("11", forKey: "y")
//                
//                
//                
//                    let newroom2 = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: moContext) as NSManagedObject
//                        newroom2.setValue("ETYB 304", forKey: "name")
//                        newroom2.setValue("33", forKey: "x")
//                        newroom2.setValue("44", forKey: "y")
//                
//                    let newroom3 = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: moContext) as NSManagedObject
//                        newroom3.setValue("Meeting room", forKey: "name")
//                        newroom3.setValue("33", forKey: "x")
//                        newroom3.setValue("44", forKey: "y")
//                
//                    let newroom4 = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: moContext) as NSManagedObject
//                        newroom4.setValue("Teacher office", forKey: "name")
//                        newroom4.setValue("33", forKey: "x")
//                        newroom4.setValue("44", forKey: "y")
//                
//                // Display the information from beacons
//                        let request = NSFetchRequest(entityName: "Room")
//                        try moContext.save()
//                        request.returnsObjectsAsFaults = false;
//                        print("Added all information from rooms")
//                
//                do {
//                                let result: NSArray =  try moContext.executeFetchRequest(request)
//                                if (result.count > 0) {
//                                    for res in result {
//                                        print(res)
//                                    }
//                                }
//                                else {
//                                    print("0 results returned")
//                                }
//                } catch{}            }
//            
//           // return fetchedResults[0,1,2] as! Room
//        } catch let error as NSError {
//            print("error")
//            print(error.localizedDescription)
//            return Room()
//        }
//    return Room()
//    }
//    
    
    
    
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

