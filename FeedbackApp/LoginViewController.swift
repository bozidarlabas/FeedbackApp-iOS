//
//  LoginViewController.swift
//  FeedbackApp
//
//  Created by Bozidar on 19.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //View Properties
    
    @IBOutlet weak var txtUsername: UITextField!

    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func login(sender: UIButton) {
        //Authentication
        let homeController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController")
        self.presentViewController(homeController!, animated: true, completion: nil)
        
    }
    //LifeCycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("test")
        if segue.identifier == "register"{
            print("segue")
        }
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
