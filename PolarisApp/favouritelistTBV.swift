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
    
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var favourites = [Favourites]()
    
    
    override func viewDidAppear(animated: Bool) {
        
        let request = NSFetchRequest(entityName: "Favourites")
        
        do {
            
        favourites =  try moContext.executeFetchRequest(request) as! [Favourites]
        }catch{}
        
        self.tableView.reloadData()
        
        
        
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
        cell.textLabel!.textColor = UIColor.whiteColor()
        
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
