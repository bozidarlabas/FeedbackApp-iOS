//
//  MyProjectsTableViewController.swift
//  FeedbackApp
//
//  Created by Bozidar on 26.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxCocoa
import RxSwift
import KCFloatingActionButton

class MyProjectsTableViewController: UITableViewController {
    
    var tableViewDataMyProjects: [ProjectModel]?
    let disposeBag = DisposeBag()
    let viewModel = ProjectsViewModel()
    var fab: KCFloatingActionButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        //getMyProjects()
        
        viewModel.fetchMyProjects()
        
        viewModel.tableViewDataAllProjects.subscribeNext{data in
            self.tableViewDataMyProjects = data
            self.tableView.reloadData()
        }.addDisposableTo(disposeBag)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelectionDuringEditing = true;
        
        
    }
    
    func initFAB(fab: KCFloatingActionButton){
        self.fab = fab
        fab.addItem("Private projects", icon: UIImage(named: "logo2")!, handler: { item in
            self.showPrivateProjects()
            fab.close()
        })
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataMyProjects == nil ? 0 : tableViewDataMyProjects!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myProjectsCell", forIndexPath: indexPath) as! ProjectsListCell
        cell.labelProjecName.text = tableViewDataMyProjects![indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let feedbackViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Feedback") as! FeedbackViewController
        //presentViewController(feedbackViewController, animated: true, completion: nil)
    }
    
    func addProject(projectModel: ProjectModel){
        viewModel.addProject(projectModel)
    }
    
    func showPrivateProjects(){
        viewModel.showPrivateProjects()
    }
    
    func showPublicProjects(){
        
    }
    
    func showAllMyProjects(){
        viewModel.fetchMyProjects()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToFeedback"{
        
        }
    }

}
