//
//  menubar_beacon.swift
//  PolarisApp
//
//  Created by Niina Kristiina on 22/04/16.
//  Copyright © 2016 Niina Kristiina. All rights reserved.
//

import Foundation

class menubar_beacon: UIViewController {
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}