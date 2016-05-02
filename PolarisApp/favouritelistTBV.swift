//
//  favouritelistTBV.swift
//  PolarisApp
//
//  Created by Niina Kristiina on 11/04/16.
//  Copyright © 2016 Niina Kristiina. All rights reserved.
//

import UIKit
import CoreData

class favouritelistTBV: UITableViewController {
    
    @IBOutlet weak var favouriteroom: UITextField!
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var favourites = [Favourites]()
    
    
    override func viewDidAppear(animated: Bool) {
        
        let request = NSFetchRequest(entityName: "Favourites")
        
        do {
            
        favourites =  try moContext.executeFetchRequest(request) as! [Favourites]
        }catch{}
        
        self.tableView.reloadData()
        
        
        
    }
    
    //coordinates are missing from this function, how to get these?
    
    @IBAction func addasfavourite(sender: AnyObject) {
        print("addasfavourite")
        
        //reference to appDelegate
        let appdel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        //reference to context
        let context: NSManagedObjectContext = appdel.managedObjectContext
        
        if (("" + favouriteroom.text! != "Type your current position as a favourite") && ("" + favouriteroom.text! != "")) {
            do {
                
                let newfavourite = NSEntityDescription.insertNewObjectForEntityForName("Favourites", inManagedObjectContext: context) as NSManagedObject
                newfavourite.setValue("" + favouriteroom.text!, forKey: "favouriteplace")
                
                try context.save()
                
                let a = UIAlertController(title: "Success", message: "Your favourite place is saved", preferredStyle: UIAlertControllerStyle.Alert)
                a.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(a, animated: true, completion: nil)
                print(newfavourite)
                let request = NSFetchRequest(entityName: "Favourites")
                
                do {
                    
                    favourites =  try moContext.executeFetchRequest(request) as! [Favourites]
                }catch{}
                
                self.tableView.reloadData()
                

        
                
            } catch {}
        }
        else {
            let b = UIAlertController(title: "Failed", message: "Type first something", preferredStyle: UIAlertControllerStyle.Alert)
            b.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(b, animated: true, completion: nil)
            
        }
        
        
    }

    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let favourite = favourites[indexPath.row]
        cell.textLabel?.text = favourite.favouriteplace
        cell.textLabel!.textColor = UIColor.darkGrayColor()
        
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "searchbyfavourite" {
            let v = segue.destinationViewController as! ViewController
            let indexpath = self.tableView.indexPathForSelectedRow
            let row = indexpath?.row
        
            
            v.favourite = favourites[row!]
        }
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == .Delete {
            
            //get the shared instance of the app delegate and the managed object context.
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let moc = appDelegate.managedObjectContext
            
            //Object is deleted and the context is saved.
            moc.deleteObject(favourites[indexPath.row])
            appDelegate.saveContext()
            
            //Table view is reloaded.
           favourites.removeAtIndex(indexPath.row)
            tableView.reloadData()
            
        }
        
    }
    

}
