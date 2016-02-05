//
//  LoginViewModelTest.swift
//  FeedbackApp
//
//  Created by Bozidar on 05.02.2016..
//  Copyright © 2016. Bozidar. All rights reserved.
//

import XCTest
@testable import FeedbackApp
import RxSwift
import RxCocoa
import SwiftyJSON

class LoginViewModelTest: XCTestCase {
    
    let viewModel = LoginViewModel()
    let disposable = DisposeBag()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidation(){
        let username = createObservable("bosko123")
        let password = createObservable("12345")
        
        viewModel.validate(username.asObservable(), password: password.asObservable())
        
        viewModel.credentialsValid?.subscribeNext{ valid in
            XCTAssertTrue(valid)
        }.addDisposableTo(disposable)
        
    }

    func testLogin(){
        
        
        let expectation = expectationWithDescription("login")
      
        viewModel.login("bosko123", password: "12345", onSuccesslogin: { json in
            XCTAssertEqual(json, "success")
            XCTAssertEqual(self.viewModel.username, "bosko123")
            expectation.fulfill()
        
        })
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func createObservable<E>(element: E) -> Observable<E> {
        return Observable.create { observer in
            observer.on(.Next(element))
            observer.on(.Completed)
            return NopDisposable.instance
        }
    }

}
