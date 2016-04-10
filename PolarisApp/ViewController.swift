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
    
    @IBAction func selfPosition(sender: AnyObject) {
        
        
    }
    
    
    @IBOutlet weak var searchView: UISearchBar!
    
    @IBOutlet weak var favouriteView: UIButton!
    
    @IBAction func favouriteAdd(sender: AnyObject) {
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



