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
        
        return cell
    }
    
    


}
