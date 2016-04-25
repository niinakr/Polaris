//
//  menubar_beacon.swift
//  PolarisApp
//
//  Created by Niina Kristiina on 22/04/16.
//  Copyright © 2016 Niina Kristiina. All rights reserved.
//

import Foundation

class menubar_beacon: UITableViewController {
    var secondArray = [String]()
    
    
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        secondArray = ["ice","blueberry","mint"]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secondArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = secondArray[indexPath.row]
        
        return cell
    }
    
}