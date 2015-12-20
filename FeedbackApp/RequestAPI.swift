//
//  ApiUser.swift
//  FeedbackApp
//
//  Created by Bozidar on 20.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private let _sharedInstance = RequestAPI()

class RequestAPI{
    
    private init(){}
    
    class var sharedInstance: RequestAPI{
        return _sharedInstance
    }
    
    func register(){
        let parameters = [
            "email": "bozidar.labas233@hotmail.com",
            "username": "bosko",
            "password": "12345678",
            "city": "Kutina",
            "country": "Croatia",
            "gender": "m",
            "birthDate": "13.12.1992",
            "registration": "registration"
        ]
        
        Alamofire.request(.POST, Constants.REGISTER, parameters: parameters)
            .responseJSON(completionHandler: { response in
            switch response.result{
            case .Success:
                print("success")
            case .Failure:
                print("error")
            }
        })
    }
    
    
}

//
//
//@Field("email") String email,
//@Field("username") String username,
//@Field("password") String password,
//@Field("city") String city,
//@Field("country") String country,
//@Field("gender") String gender,
//@Field("birthDate") String birthDate,
//@Field("registration") String registration,