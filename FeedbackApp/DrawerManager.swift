//
//  DrawerManager.swift
//  FeedbackApp
//
//  Created by Bozidar on 27.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import Foundation
import MMDrawerController

//Facade Design Pattern
class DrawerManager{
    
    private var centerViewController: HomeViewController?
    private var leftViewController: DrawerController?
    private var drawerController: MMDrawerController?
    
   
    func initializeControllers(storyBoard: UIStoryboard){
        
        centerViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeViewController") as? HomeViewController
        
        leftViewController = storyBoard.instantiateViewControllerWithIdentifier("LeftSideViewController") as? DrawerController
    }
    
    func setUpDrawer(){
        drawerController = MMDrawerController(centerViewController: centerViewController, leftDrawerViewController: leftViewController)
        
        drawerController!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        drawerController!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.All
    }
    
    func getDrawerController()->MMDrawerController{
        return self.drawerController!
    }
}
