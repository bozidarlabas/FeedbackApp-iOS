//
//  CustomAlertView.swift
//  FeedbackApp
//
//  Created by Bozidar on 20.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class CustomAlertView: UIAlertView {
    
    static func showAlertView(title: String, message: String, buttonTitle: String)->UIAlertView{
        let alert = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButtonWithTitle(buttonTitle)
        alert.show()
        return alert
    }

}
