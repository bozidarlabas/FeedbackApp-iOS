//
//  LoginViewController.swift
//  FeedbackApp
//
//  Created by Bozidar on 19.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    //OUTLETS
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var viewModel = LoginViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //VIEWMODEL
        viewModel = LoginViewModel()
        viewModel.validate(txtUsername.rx_text.asObservable(), password: txtPassword.rx_text.asObservable())
        
        loginBtn.rx_tap
            .withLatestFrom(viewModel.credentialsValid!)
            .subscribeNext{valid in
                self.viewModel.login(self.txtUsername.text!, password: self.txtPassword.text!, onSuccesslogin: self.onSuccesslogin)
                if(valid == true){self.viewModel.storeLogedUser()}
            }
            .addDisposableTo(disposeBag)

        
    }
    
    func onSuccesslogin(response: JSON)->Void{
        if response == "success"{
            goToHomeScreen()
        }else{
            CustomAlertView.showAlertView("Login failed!", message: "Wrong username or password", buttonTitle: "OK")
        }
    }
    
    func goToHomeScreen(){
        let drawerManager = DrawerManager()
        drawerManager.initializeControllers(self.storyboard!)
        drawerManager.setUpDrawer()
        //let tabbarctr: UITabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("tabbarctr") as! HomeViewController
        self.presentViewController(drawerManager.getDrawerController(), animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("test")
        if segue.identifier == "register"{
            print("segue")
        }
    }
    
}
