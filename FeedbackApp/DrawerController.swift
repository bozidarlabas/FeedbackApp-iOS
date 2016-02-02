//
//  DrawerController.swift
//  FeedbackApp
//
//  Created by Bozidar on 26.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class DrawerController: UIViewController {

    @IBAction func logout() {
        self.performSegueWithIdentifier("goToLogin", sender: self)
    }
}
