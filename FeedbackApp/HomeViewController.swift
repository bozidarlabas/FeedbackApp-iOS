//
//  HomeViewController.swift
//  FeedbackApp
//
//  Created by Bozidar on 19.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit
import MMDrawerController

class HomeViewController: UIViewController {

    @IBOutlet weak var navButton1: UIButton!
    @IBOutlet weak var navButton2: UIButton!
    @IBOutlet weak var scrollViewContent: UIView!
    @IBOutlet weak var scrollViewController: UIScrollView!
    @IBOutlet weak var scrollViewWidth: NSLayoutConstraint!
    let numberOfScreens: CGFloat = 2
    @IBOutlet weak var drawerContainer: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollViewWidth.constant = self.view.frame.size.width * numberOfScreens
        UINavigationBar.appearance().barTintColor = UIColor.redColor()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAllProjects() {
        scrollViewController.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @IBAction func showMyProjects(sender: UIButton) {
        scrollViewController.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0), animated: true)
    }
    
    func setControllers(){
        let width = self.view.frame.size.width
        let allProjectsController: AllProjectsTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AllProjects") as! AllProjectsTableViewController
        let myProjectsController: MyProjectsTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MyProjects") as! MyProjectsTableViewController
        allProjectsController.view.frame = CGRect(x: 0, y: 0, width: width, height: self.view.frame.size.height)
        myProjectsController.view.frame = CGRect(x: width, y: 0, width: width, height: self.view.frame.size.height)
        
        self.addChildViewController(allProjectsController)
        self.addChildViewController(myProjectsController)
        
        self.scrollViewContent.addSubview(allProjectsController.view)
        self.scrollViewContent.addSubview(myProjectsController.view)
        
        
    }

    @IBAction func openDrawer(sender: UIBarButtonItem) {
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
  
//    @IBAction func logout(sender: UIButton) {
//        self.performSegueWithIdentifier("goToLogin", sender: self)
//    }
}
