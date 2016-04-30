//
//  MyCustomButton.swift
//  PolarisApp
//
//  Created by Niina Kristiina on 18/04/16.
//  Copyright © 2016 Niina Kristiina. All rights reserved.
//

import Foundation
import UIKit

class MyCustomButton: UIButton {
    
    let borderAlpha : CGFloat = 0.7
//    var mycolor = UIColor(netHex:#68efad)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 15.0;
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 2.0
        self.layer.shadowColor = UIColor.whiteColor().CGColor
        self.layer.shadowOpacity = 0.3
//        self.backgroundColor = UIColor.clearColor()
    }
}
