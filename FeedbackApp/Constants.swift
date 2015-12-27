//
//  Constants.swift
//  FeedbackApp
//
//  Created by Bozidar on 19.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import Foundation

struct Constants {
    
    static let KEY_USER_LOGGED: String = "userAlreadyLogged"
    
    static let KEY_USERNAME: String = "username"
    
    static let ENDPOINT: String = "http://arka.foi.hr"
    
    static let REGISTER: String = "\(ENDPOINT)/WebDiP/2013_projekti/WebDiP2013_038/registration.php"
    
    static let LOGIN: String = "\(ENDPOINT)/WebDiP/2013_projekti/WebDiP2013_038/login.php"
    
    static let FETCH_ALL_PROJECTS = "\(ENDPOINT)/WebDiP/2013_projekti/WebDiP2013_038/projects.php"
    
    static let FETCH_MY_PROJECTS = "\(ENDPOINT)/WebDiP/2013_projekti/WebDiP2013_038/projects.php"
    
}