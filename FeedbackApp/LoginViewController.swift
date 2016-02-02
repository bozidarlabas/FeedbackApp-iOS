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
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //VIEWMODEL
        let viewModel = LoginViewModel(username: txtUsername.rx_text.asObservable(), password: txtPassword.rx_text.asObservable())
        
        loginBtn.rx_tap
            .withLatestFrom(viewModel.credentialsValid)
            .subscribeNext{valid in
                viewModel.login(self.txtUsername.text!, password: self.txtPassword.text!)
            }
            .addDisposableTo(disposeBag)
        
        viewModel.userLogged
            .subscribeNext{
                userLogged in self.onAuthenticationFinished(userLogged!, viewModel: viewModel)
            }
            .addDisposableTo(disposeBag)
        
    }
    
    private func onAuthenticationFinished(valid: Bool, viewModel: LoginViewModel){
        if(valid){
            goToHomeScreen()
        }else{
            CustomAlertView.showAlertView("Login failed!", message: "Wrong username or password", buttonTitle: "OK")
        }
    }
    
    func goToHomeScreen(){
        let drawerManager = DrawerManager()
        drawerManager.initializeControllers(self.storyboard!)
        drawerManager.setUpDrawer()
        self.presentViewController(drawerManager.getDrawerController(), animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("test")
        if segue.identifier == "register"{
            print("segue")
        }
    }
    
}
