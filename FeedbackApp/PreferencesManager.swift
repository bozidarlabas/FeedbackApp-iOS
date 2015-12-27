//
//  PreferencesManager.swift
//  FeedbackApp
//
//  Created by Bozidar on 25.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import Foundation

class PreferencesManager{
    
    struct UserKeys {
        static let USERNAME: String = "username"
    }
    
    
    func storeUser(username: String){
        let preferences = NSUserDefaults.standardUserDefaults()
        preferences.setObject(username, forKey: UserKeys.USERNAME)
        preferences.synchronize()    }
    
    func loadUser()->User{
        let preferences = NSUserDefaults.standardUserDefaults()
        let username = preferences.objectForKey(UserKeys.USERNAME) as! String
        let user: User = User(username: username)
        return user
    }
}

