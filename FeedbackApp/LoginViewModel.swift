//
//  LoginViewModel.swift
//  FeedbackApp
//
//  Created by Bozidar on 01.02.2016..
//  Copyright © 2016. Bozidar. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyJSON

import Foundation

class LoginViewModel{
    
    var credentialsValid: Observable<Bool>
    var userLogged = PublishSubject<Bool?>()
    
    //MODEL
    var username: String?{
        didSet{
            
        }
    }
    
    init(username: Observable<String>, password: Observable<String>){
        let usernameValid = username
            .map{$0.utf8.count > 3}
        
        let passwordValid = password
            .map{$0.utf8.count > 3}
        
        credentialsValid = Observable.combineLatest(usernameValid, passwordValid){$0 && $1}
        
    }
    
    private func notifyViewController(authenticatedUser: Bool){
        self.userLogged.on(.Next(authenticatedUser))
    }
    
    func login(username: String, password: String){
        self.username = username
        RequestAPI.sharedInstance.login(username, password: password, withSuccess: onSuccesslogin)
    }
    
    func onSuccesslogin(json: JSON)->Void{
        if json == "success"{
            notifyViewController(true)
            storeLogedUser()
        }else{
            notifyViewController(false)
        }
    }
    
    func storeLogedUser(){
        let preferenceManager: PreferencesManager = PreferencesManager()
        preferenceManager.storeUser(username!)
    }
    
    
    
}