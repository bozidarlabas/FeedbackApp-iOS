//
//  User.swift
//  FeedbackApp
//
//  Created by Bozidar on 25.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import Foundation

class User{
    
    private var username = String()
    
    init(username: String){
        self.username = username
    }

    func getUsername()->String{
        return self.username
    }
    
    func initWithCoder(decoder: NSCoder)->User{
        self.username = decoder.decodeObjectForKey("username") as! String
        return self
    }
    
    func encodeWithCoder(coder: NSCoder!){
        coder.encodeObject(username, forKey: "username")
    }
}