//
//  RegistrationViewModelTest.swift
//  FeedbackApp
//
//  Created by Bozidar on 05.02.2016..
//  Copyright © 2016. Bozidar. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import FeedbackApp

class RegistrationViewModelTest: XCTestCase {
    
    let viewModel = RegisterViewModel()
    let disposable = DisposeBag()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testRegister() {
        let expectation = expectationWithDescription("register")
        
        viewModel.register("bosko1234", email: "bozidar@gmail.com", password: "12345", city: "Kutina", country: "Croatia", onRegistrationFinished: { json in
            XCTAssertEqual(json, "failed_email_username")
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
    
    func testValidationSuccessfulEmail(){
        let username = createObservable("bosko123")
        let password = createObservable("12345")
        let email = createObservable("bozidar@gmail.com")
        
        viewModel.validate(username.asObservable(), password: password.asObservable(), email: email.asObservable())
        
        viewModel.credentialsValid?.subscribeNext{ valid in
            XCTAssertTrue(valid)
            }.addDisposableTo(disposable)
    }
    
    func testValidationUnsuccessfulEmail(){
        let username = createObservable("bosko123")
        let password = createObservable("12345")
        let email = createObservable("bozidar.gmail.com")
        
        viewModel.validate(username.asObservable(), password: password.asObservable(), email: email.asObservable())
        
        viewModel.credentialsValid?.subscribeNext{ valid in
            XCTAssertFalse(valid)
            }.addDisposableTo(disposable)
    }

}
