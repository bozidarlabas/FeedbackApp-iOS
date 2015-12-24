//
//  HomeViewController.swift
//  FeedbackApp
//
//  Created by Bozidar on 19.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var navButton1: UIButton!
    @IBOutlet weak var navButton2: UIButton!
    @IBOutlet weak var scrollViewContent: UIView!
    @IBOutlet weak var scrollViewController: UIScrollView!
    @IBOutlet weak var scrollViewWidth: NSLayoutConstraint!
    let numberOfScreens: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollViewWidth.constant = self.view.frame.size.width * numberOfScreens
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setControllers(){
        let width = self.view.frame.size.width
        let allProjectsController: AllProjectsTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AllProjects") as! AllProjectsTableViewController
        allProjectsController.view.frame = CGRect(x: 0, y: 0, width: width, height: self.view.frame.size.height)
        
        self.addChildViewController(allProjectsController)
        self.scrollViewContent.addSubview(allProjectsController.view)
        
        
    }

  
//    @IBAction func logout(sender: UIButton) {
//        self.performSegueWithIdentifier("goToLogin", sender: self)
//    }
}
