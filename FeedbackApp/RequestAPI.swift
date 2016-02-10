//
//  ApiUser.swift
//  FeedbackApp
//
//  Created by Bozidar on 20.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxCocoa
import RxSwift
import SwiftyJSON

private let _sharedInstance = RequestAPI()

class RequestAPI{
    
    private init(){}
    
    class var sharedInstance: RequestAPI{
        return _sharedInstance
    }
    
    var errorAlertController = PublishSubject<UIAlertController>()
    var disposeBag = DisposeBag()
    
    //Constants
    struct Constants {
        static let ENDPOINT: String = "http://arka.foi.hr"
        static let REGISTER: String = "\(ENDPOINT)/WebDiP/2013_projekti/WebDiP2013_038/registration.php"
        static let LOGIN: String = "\(ENDPOINT)/WebDiP/2013_projekti/WebDiP2013_038/login.php"
        static let FETCH_ALL_PROJECTS = "\(ENDPOINT)/WebDiP/2013_projekti/WebDiP2013_038/projects.php"
        static let FETCH_MY_PROJECTS = "\(ENDPOINT)/WebDiP/2013_projekti/WebDiP2013_038/projects.php"
        static let STORE_NEW_PROJECT = "\(ENDPOINT)/WebDiP/2013_projekti/WebDiP2013_038/projects.php"
        static let FETCH_MY_PRIVATE_PROJECTS = "\(ENDPOINT)/WebDiP/2013_projekti/WebDiP2013_038/projects.php"
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
        
        Alamofire.request(.POST, Constants.REGISTER, parameters: parameters).rx_responseJSON()
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onNext: {(r, json) -> Void in
                    let jsonForValidation = JSON(json)
                    
                    if let error = jsonForValidation["message"].string{
                        print("error: \(error)")
                        self.postError("Error", message: error)
                        return
                    }
                    withSuccess(jsonForValidation)
                },
                onError: {error in
                    print("Error")
                    let gotError = error as NSError
                    print(gotError.domain)
                    print(gotError.code)
                    self.postError("\(gotError.code)", message: gotError.domain)}
            )
            .addDisposableTo(disposeBag)
    }
    
    //MARK: Login
    
    func login(username: String, password: String, withSuccess: ((JSON)->Void)){
        let parameters = [
            "password": password,
            "username": username
        ]
        
        Alamofire.request(Method.POST, Constants.LOGIN, parameters: parameters).rx_responseJSON()
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onNext: {(r, json) -> Void in
                    let jsonForValidation = JSON(json)
                    
                    if let error = jsonForValidation["message"].string{
                        print("error: \(error)")
                        self.postError("Error", message: error)
                        return
                    }
                    withSuccess(jsonForValidation)
                },
                onError: {error in
                    print("Error")
                    let gotError = error as NSError
                    print(gotError.domain)
                    print(gotError.code)
                    self.postError("\(gotError.code)", message: gotError.domain)}
            )
            .addDisposableTo(disposeBag)
    }
    
    //MARK: All Projects
    
    func fetchAllProjects(username: String, withSuccess: ((JSON)->Void))->Void{
        let parameters = [
            "allprojects": "allprojects",
            "username": username
        ]
        
        Alamofire.request(.POST, Constants.FETCH_ALL_PROJECTS, parameters: parameters).rx_responseJSON()
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onNext: {(r,json) -> Void in
                    let jsonResponse = JSON(json)
                    
                    if let error = jsonResponse["message"].string{
                        print("error: \(error)")
                        self.postError("Error", message: error)
                        return
                    }
                    print("aaa> \(jsonResponse)")
                    withSuccess(jsonResponse)
                },
                onError: {error in
                    print("Error")
                    let gotError = error as NSError
                    print(gotError.domain)
                    print(gotError.code)
                    self.postError("\(gotError.code)", message: gotError.domain)}
                
            ).addDisposableTo(disposeBag)
        
    }
    
    func fetchMyProjects(username: String, withSuccess: ((JSON)->Void)){
        let parameters = [
            "myprojects": "myprojects",
            "username": username
        ]
        
        Alamofire.request(.POST, Constants.FETCH_MY_PROJECTS, parameters: parameters).rx_responseJSON()
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onNext: {(r,json) -> Void in
                    let jsonResponse = JSON(json)
                    
                    if let error = jsonResponse["message"].string{
                        print("error: \(error)")
                        self.postError("Error", message: error)
                        return
                    }
                    withSuccess(jsonResponse)
                },
                onError: {error in
                    print("Error")
                    let gotError = error as NSError
                    print(gotError.domain)
                    print(gotError.code)
                    self.postError("\(gotError.code)", message: gotError.domain)}
                
            ).addDisposableTo(disposeBag)
        
    }
    
    //.on(event: Event<Element>)
    func postError(title: String, message: String){
        errorAlertController.on(
            .Next(UIAlertController(
                title: title,
                message: message,
                preferredStyle: .Alert)))
    }
    
    func addNewProject(username: String, projectId: String){
        let parameters = [
            "addproject" : "addproject",
            "username" : username,
            "projectid" : projectId
        ]
        
        Alamofire.request(.POST, Constants.STORE_NEW_PROJECT, parameters: parameters).rx_responseJSON()
        .subscribe(
            onNext: {(r,json) -> Void in
                let jsonResponse = JSON(json)
                
                if let error = jsonResponse["message"].string{
                    print("error: \(error)")
                    self.postError("Error", message: error)
                    return
                }
            },
            onError: {error in
                print("Error")
                let gotError = error as NSError
                print(gotError.domain)
                print(gotError.code)
                self.postError("\(gotError.code)", message: gotError.domain)}
            
            ).addDisposableTo(disposeBag)
        
    }
    
    func fetchPrivateProjects(username: String, withSuccess: ((JSON)->Void)){
        let parameters = [
            "privateprojects" : "privateprojects",
            "username" : username
        ]
        
        Alamofire.request(.POST, Constants.STORE_NEW_PROJECT, parameters: parameters).rx_responseJSON()
            .subscribe(
                onNext: {(r,json) -> Void in
                    let jsonResponse = JSON(json)
                    
                    if let error = jsonResponse["message"].string{
                        print("error: \(error)")
                        self.postError("Error", message: error)
                        return
                    }
                    withSuccess(jsonResponse)
                },
                onError: {error in
                    print("Error")
                    let gotError = error as NSError
                    print(gotError.domain)
                    print(gotError.code)
                    self.postError("\(gotError.code)", message: gotError.domain)}
                
            ).addDisposableTo(disposeBag)
        
    }
    
    
}
