//
//  HomeViewController.swift
//  FeedbackApp
//
//  Created by Bozidar on 19.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //When home screen is loaded move to login screen
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let prefs: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn: Int = prefs.integerForKey(Constants.KEY_USER_LOGGED) as Int
        
        if isLoggedIn != 1{
            self.performSegueWithIdentifier("goToLogin", sender: self)
        }else{
            self.usernameLabel.text = prefs.valueForKey(Constants.KEY_USERNAME) as! NSString as String
        }
    }

    @IBAction func logout(sender: UIButton) {
        self.performSegueWithIdentifier("goToLogin", sender: self)
    }
}
