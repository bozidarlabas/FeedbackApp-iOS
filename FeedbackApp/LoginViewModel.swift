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

public class LoginViewModel{
    
    var credentialsValid = Observable<Bool>?()
    public var userLogged = PublishSubject<Bool?>()
    
    //MODEL
    var username: String?
    
    
    public init(){}
    
    func validate(username: Observable<String>, password: Observable<String>){
        let usernameValid = username
            .map{$0.utf8.count > 3}
        
        let passwordValid = password
            .map{$0.utf8.count > 3}
        
        credentialsValid = Observable.combineLatest(usernameValid, passwordValid){$0 && $1}

    }
    
    public func login(username: String, password: String, onSuccesslogin: (JSON)->Void){
        self.username = username
        RequestAPI.sharedInstance.login(username, password: password, withSuccess: onSuccesslogin)
    }
    
    public func storeLogedUser(){
        let preferenceManager: PreferencesManager = PreferencesManager()
        preferenceManager.storeUser(username!)
    }
    
    
    
}