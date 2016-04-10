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


class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchView: UISearchBar!
    
    @IBOutlet weak var favouriteView: UIButton!
    
    @IBAction func selfPosition(sender: AnyObject) {
    print("position button pressed")
        
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
        
        let newfavourite = NSEntityDescription.insertNewObjectForEntityForName("Favourites", inManagedObjectContext: context) as NSManagedObject
        newfavourite.setValue("" + searchView.text!, forKey: "favouriteplace")
        
        do {
            try context.save()
            print(newfavourite)
        } catch {}
        
        

    }
    

    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

