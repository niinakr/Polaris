//
//  MenubarVC.swift
//  PolarisApp
//
//  Created by Niina Kristiina on 22/04/16.
//  Copyright © 2016 Niina Kristiina. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MenubarVC: UITableViewController {
    
    var tableArray = [String]()
    
    @IBOutlet weak var Avatar: UILabel!
    
    
    func getCurrentAvatar()-> User {
        print("getCurrentAvatar() function")
        let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let req = NSFetchRequest(entityName: "User")
        
        do {
            let fetchedResults = try moContext.executeFetchRequest(req)
            if fetchedResults.count == 0 {
                print("fetchedResults is == 0")
                let newavatar2 = NSEntityDescription.insertNewObjectForEntityForName("User",inManagedObjectContext: moContext) as NSManagedObject
                newavatar2.setValue("Unknown", forKey: "avatar_name")
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
    
    override func viewDidAppear(animated: Bool) {
        // update label with avatar name
        let user:User = getCurrentAvatar()
        Avatar.text = "   Your avatar:" + user.avatar_name!
    }
    
    
    
    override func viewDidLoad() {
        tableArray = ["Beacons","Register","Homepage","Your favourite"]
        
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
