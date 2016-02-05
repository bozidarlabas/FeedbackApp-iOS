//
//  RegisterViewModel.swift
//  FeedbackApp
//
//  Created by Bozidar on 03.02.2016..
//  Copyright © 2016. Bozidar. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

class RegisterViewModel{
    var credentialsValid: Observable<Bool>
    var userRegistered = PublishSubject<Bool?>()
    
    init(username: Observable<String>, password: Observable<String>, email: Observable<String>){
        let usernameValid = username.map{$0.utf8.count > 3}
        let passwordValid = password.map{$0.utf8.count > 3}
        let emailValid = email.map{$0.isValidEmail()}
        
        credentialsValid = Observable.combineLatest(usernameValid, passwordValid, emailValid){$0 && $1 && $2}
    }
    
    func register(username: String, email: String, password: String, city: String, country: String){
        RequestAPI.sharedInstance.register(username, password: password, email: email, city: city, country: country, withSuccess: onRegistrationFinished)
    }
    
    func onRegistrationFinished(json: JSON) -> Void{
        if json == "success"{
            notifyViewController(true)
        }else{
            notifyViewController(false)
        }
    }
    
    private func notifyViewController(registeredUser: Bool){
        userRegistered.on(.Next(registeredUser))
    }
    
}

extension String {
    func isValidEmail() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .CaseInsensitive)
            return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
}
