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


class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchView: UISearchBar!
    
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
        } catch{}
        

        
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

        
    
    
    @IBAction func displaybeacons(sender: AnyObject) {
        print("displaybeacons button pressed")
        
        
        //reference to appDelegate
        let appdel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)

        
        //reference to context
        let context: NSManagedObjectContext = appdel.managedObjectContext
        
        // save data from beacons
        let newbeacon1 = NSEntityDescription.insertNewObjectForEntityForName("Beacons", inManagedObjectContext: context) as NSManagedObject
        newbeacon1.setValue("1881818jdjd89383", forKey: "id")
        newbeacon1.setValue("2222", forKey: "major")
        newbeacon1.setValue("1111", forKey: "minor")
        newbeacon1.setValue("test", forKey: "name")
        
        let newbeacon2 = NSEntityDescription.insertNewObjectForEntityForName("Beacons", inManagedObjectContext: context) as NSManagedObject
        newbeacon2.setValue("1881818j22289383", forKey: "id")
        newbeacon2.setValue("3333", forKey: "major")
        newbeacon2.setValue("4444", forKey: "minor")
        newbeacon2.setValue("test2", forKey: "name")
        
        
        //Display the information from beacons
        let request = NSFetchRequest(entityName: "Beacons")
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        if let s = favourite {
            
            searchView.text = s.favouriteplace
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
        
        //add rooms as core data
        
        //reference to appDelegate
        let appdel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        
        //reference to context
        let context: NSManagedObjectContext = appdel.managedObjectContext
        
        // save data from beacons
        let newroom1 = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: context) as NSManagedObject
        newroom1.setValue("test1", forKey: "roomName")
        newroom1.setValue("2222", forKey: "beaconUUID")
        
        
        let newroom2 = NSEntityDescription.insertNewObjectForEntityForName("Room", inManagedObjectContext: context) as NSManagedObject
        newroom2.setValue("test2", forKey: "roomName")
        newroom2.setValue("3333", forKey: "beaconUUID")
        
        
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
    
    
}

