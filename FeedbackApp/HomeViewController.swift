//
//  HomeViewController.swift
//  FeedbackApp
//
//  Created by Bozidar on 19.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit
import MMDrawerController
import KCFloatingActionButton

class HomeViewController: UITabBarController, HomeViewProtocol {

    //OUTLETS
    @IBOutlet weak var navButton1: UIButton!
    @IBOutlet weak var navButton2: UIButton!
    @IBOutlet weak var scrollViewContent: UIView!
    @IBOutlet weak var scrollViewController: UIScrollView!
    @IBOutlet weak var scrollViewWidth: NSLayoutConstraint!
    @IBOutlet weak var drawerContainer: UINavigationItem!
    
    //PROPERTIES
    let numberOfScreens: CGFloat = 2
    var myProjectsController: MyProjectsTableViewController?
    var fab = KCFloatingActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
       // initUI()
      //  initFloatingActionButton()
    }
    
    func initFloatingActionButton(){
        self.fab = KCFloatingActionButton()
        fab.plusColor = UIColor.whiteColor()
        fab.buttonColor = UIColor(red: 33.0/255.0, green: 150.0/255.0, blue: 243.0/255.0, alpha: 1.0)
        self.view.addSubview(fab)
    }
    
    func initUI(){
        self.scrollViewWidth.constant = self.view.frame.size.width * numberOfScreens
        //UINavigationBar.appearance().barTintColor = UIColor.redColor()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       // setTabControllers()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
     //   self.navigationController!.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 150.0/255.0, blue: 243.0/255.0, alpha: 1.0)
    }
    
    @IBAction func showAllProjects() {
        scrollViewController.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        fab.hidden = true
    }
    
    @IBAction func showMyProjects(sender: UIButton) {
        scrollViewController.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0), animated: true)
        fab.hidden = false
        
    }
    
    func setTabControllers(){
        let width = self.view.frame.size.width
        let allProjectsController: AllProjectsTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AllProjects") as! AllProjectsTableViewController
        allProjectsController.setHomeProtocol(self)
        
        myProjectsController = self.storyboard?.instantiateViewControllerWithIdentifier("MyProjects") as? MyProjectsTableViewController
        myProjectsController!.initFAB(fab)
        
        allProjectsController.view.frame = CGRect(x: 0, y: 0, width: width, height: self.view.frame.size.height)
        myProjectsController!.view.frame = CGRect(x: 0, y: 0, width: width, height: self.view.frame.size.height)
        
        self.addChildViewController(allProjectsController)
        self.addChildViewController(myProjectsController!)
        
        self.scrollViewContent.addSubview(allProjectsController.view)
        self.scrollViewContent.addSubview(myProjectsController!.view)
    }

    @IBAction func openDrawer(sender: UIBarButtonItem) {
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    func addProjectToMyProjects(projectModel: ProjectModel)->Void{
        print("clicked: \(projectModel.idProjects)")
        myProjectsController!.addProject(projectModel)
    }
}

