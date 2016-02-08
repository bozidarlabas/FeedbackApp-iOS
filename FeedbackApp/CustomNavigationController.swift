//
//  CustomViewController.swift
//  FeedbackApp
//
//  Created by Bozidar on 26.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().barTintColor = UIColor(red: 33.0/255.0, green: 150.0/255.0, blue: 243.0/255.0, alpha: 1.0)
        
    }
}
