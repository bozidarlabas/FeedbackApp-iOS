//
//  RegisterViewController.swift
//  FeedbackApp
//
//  Created by Bozidar on 18.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegisterViewController: UIViewController, UIAlertViewDelegate {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func register(sender: AnyObject) {
        let username: String = txtUsername.text!
        let password: String = txtPassword.text!
        let email: String = txtEmail.text!
        let city: String = txtCity.text!
        let country: String = txtCountry.text!
        
        if validate(username, password: password){
            sendRegistrationRequest(username, password: password, email: email, city: city, country: country)
        }
        
        
    }
    
    func validate(username: NSString, password: NSString)->Bool{
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            CustomAlertView.showAlertView("Sign Up Failed!", message: "Please enter Username and Password", buttonTitle: "OK")
            return false
        }
        return true
    }
    
    func sendRegistrationRequest(username: String, password: String, email: String, city: String, country: String){
        RequestAPI.sharedInstance.register(username, password: password, email: email, city: city, country: country, withSuccess: onSuccessRegister)
    }
    
    
    func onSuccessRegister(json: JSON)->Void{
        if json == "success"{
            print("Registriran: \(json)")
            let alertView: UIAlertView =  CustomAlertView.showAlertView("Successful registration!", message: "You are registered as \(txtUsername.text!)", buttonTitle: "OK")
            alertView.delegate = self
        }else{
            CustomAlertView.showAlertView("Sign Up Failed!", message: "\(json)", buttonTitle: "OK")
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
