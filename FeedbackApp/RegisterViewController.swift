//
//  RegisterViewController.swift
//  FeedbackApp
//
//  Created by Bozidar on 18.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = RegisterViewModel()
        viewModel.validate(txtUsername.rx_text.asObservable(), password: txtPassword.rx_text.asObservable(), email: txtEmail.rx_text.asObservable())
        
        
        btnRegister.rx_tap
            .withLatestFrom(viewModel.credentialsValid!)
            .subscribeNext{
                self.onValidationFinished($0, viewModel: viewModel)
            }.addDisposableTo(disposeBag)
        
    }
    
    func onRegistrationFinished(json: JSON) -> Void{
        if json == "success"{
            let alertView: UIAlertView =  CustomAlertView.showAlertView("Successful registration!", message: "You are registered as \(txtUsername.text!)", buttonTitle: "OK")
            alertView.delegate = self
        }else{
            CustomAlertView.showAlertView("Sign Up Failed!", message: "Error", buttonTitle: "OK")
        }
    }
    
    func onValidationFinished(isValidated: Bool, viewModel: RegisterViewModel){
        if(isValidated){
            viewModel.register(txtUsername.text!, email: txtEmail.text!, password: txtPassword.text!, city: txtCity.text!, country: txtCountry.text!, onRegistrationFinished: onRegistrationFinished)
        }else{
            CustomAlertView.showAlertView("Failed validation!", message: "incorect username, password or email format", buttonTitle: "OK")
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
