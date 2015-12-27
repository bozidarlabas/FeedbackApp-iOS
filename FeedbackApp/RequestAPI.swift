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
    
    func register(username: String, password: String, email: String, city: String, country: String, withSuccess: ((JSON)->Void)){
        let parameters = [
            "email": email,
            "username": username,
            "password": password,
            "city": city,
            "country": country,
            "gender": "m",
            "birthDate": "13.12.1992",
            "registration": "registration"
        ]
        
        Alamofire.request(.POST, Constants.REGISTER, parameters: parameters)
            .responseJSON(completionHandler: { response in
            switch response.result{
            case .Success:
                if let value = response.result.value{
                    let json = JSON(value)
                    withSuccess(json)
                }
                
            case .Failure:
                print("error")
            }
        })
    }
    
    func login(username: String, password: String, withSuccess: ((JSON)->Void)){
        let parameters = [
            "password": password,
            "username": username
        ]
        
        Alamofire.request(.POST, Constants.LOGIN, parameters: parameters)
            .responseJSON(completionHandler: {response in
                switch response.result{
                case .Success:
                    if let value = response.result.value{
                        let json = JSON(value)
                        withSuccess(json)
                    }
                case .Failure:
                    print("error")
                }})
    }
    
    func fetchAllProjects(username: String, withSuccess: ((JSON)->Void))->Void{
        let parameters = [
            "allprojects": "allprojects",
            "username": username
        ]
        
        Alamofire.request(.POST, Constants.FETCH_ALL_PROJECTS, parameters: parameters)
            .responseJSON(completionHandler: { response in
                switch response.result{
                case .Success:
                    if let value = response.result.value{
                        let json = JSON(value)
                        withSuccess(json)
                    }
                case .Failure:
                    print("Error")
                }})
    }
    
    func fetchMyProjects(username: String, withSuccess: ((JSON)->Void)){
        let parameters = [
            "myprojects": "myprojects",
            "username": username
        ]
        
        Alamofire.request(.POST, Constants.FETCH_MY_PROJECTS, parameters: parameters)
        .responseJSON(completionHandler: {
            response in
            switch response.result{
            case .Success:
                if let value = response.result.value{
                    let json = JSON(value)
                    withSuccess(json)
                }
            case .Failure:
                print("Error")
            }
        })
    }
//    
//    @POST("/WebDiP/2013_projekti/WebDiP2013_038/projects.php")
//    public void fetchMyrojects(
//    @Field("myprojects") String allProjects,
//    @Field("username") String username,
//    Callback<List<ProjectModel>> projects);

    
}
