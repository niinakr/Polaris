//
//  MenubarVC.swift
//  PolarisApp
//
//  Created by Niina Kristiina on 22/04/16.
//  Copyright © 2016 Niina Kristiina. All rights reserved.
//

import Foundation


class MenubarVC: UITableViewController {
    
    var tableArray = [String]()
    
    override func viewDidLoad() {
        tableArray = ["Beacons","Rooms", "Homepage"]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCellWithIdentifier(tableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = tableArray[indexPath.row]

        
        return cell
    }
    
}