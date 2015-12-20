//
//  RegisterViewController.swift
//  FeedbackApp
//
//  Created by Bozidar on 18.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func register(sender: AnyObject) {
        var username: String = txtUsername.text!
        var password: String = txtPassword.text!
        
        if validate(username, password: password){
            sendRegistrationRequest(username, password: password)
        }
        
        
    }
    
    func validate(username: NSString, password: NSString)->Bool{
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            return false
        }
        return true
    }
    
    func sendRegistrationRequest(username: NSString, password: NSString){
        RequestAPI.sharedInstance.register()
        
    }
    
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
