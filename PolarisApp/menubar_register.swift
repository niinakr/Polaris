//
//  menubar_register.swift
//  PolarisApp
//
//  Created by Niina Kristiina on 25/04/16.
//  Copyright © 2016 Niina Kristiina. All rights reserved.
//

import Foundation
import CoreData

class menubar_register: UIViewController {
  
    @IBOutlet weak var avatar: UITextField!

    

    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    @IBAction func saveData(sender: UIButton) {
      
        print(avatar.text!)
        
        //reference to appDelegate
        let appdel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        //reference to context
        let context: NSManagedObjectContext = appdel.managedObjectContext
        
        if (("" + avatar.text! != "Type your name") && ("" + avatar.text! != "")) {
            do {
                
                let newavatar = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context) as NSManagedObject
                newavatar.setValue("" + avatar.text!, forKey: "avatar_name")
                
                try context.save()
                let a = UIAlertView(title: "Success", message: "Your avatar is saved", delegate: nil, cancelButtonTitle: "OK")
                a.show()
                print(newavatar)
            } catch {}
        }
        else {
            let b = UIAlertView(title: "Failed", message: "Type first something", delegate: nil, cancelButtonTitle: "OK")
            b.show()
            
            
        }

        
    }
    //hide keyboard when clicking anywhere
    @IBAction func hideKB(sender: AnyObject) {
        
        for v in self.view.subviews
        {
            if v .isKindOfClass(UITextField)
            {
                v.resignFirstResponder()
            }
        }
    }
}