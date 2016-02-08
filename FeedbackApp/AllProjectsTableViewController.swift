//
//  AllProjectsTableViewController.swift
//  FeedbackApp
//
//  Created by Bozidar on 24.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxCocoa
import RxSwift
import JLToast


class AllProjectsTableViewController: UITableViewController {
    
    
    var tableViewDataAllProjects: [ProjectModel]?
    let disposeBag = DisposeBag()
    let viewModel = ProjectsViewModel()
    var homeController: HomeViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.getAllProjects()
        viewModel.fetchAllProjects()
        
        viewModel.tableViewDataAllProjects.subscribeNext{data in
            self.tableViewDataAllProjects = data
            self.tableView.reloadData()
        }.addDisposableTo(disposeBag)
        
        self.tableView.delegate = self
    }
    
    func setHomeProtocol(homeController: HomeViewProtocol){
        self.homeController = homeController
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataAllProjects == nil ? 0 : tableViewDataAllProjects!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("allProjectsCell", forIndexPath: indexPath) as! ProjectsListCell
        cell.labelProjecName.text = tableViewDataAllProjects![indexPath.row].name
        cell.buttonConfirm.tag = (Int)(tableViewDataAllProjects![indexPath.row].idProjects!) ?? 0
        cell.buttonConfirm.addTarget(self, action: "selectProject:", forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    
    func selectProject(selectedButton: UIButton){
        if let projectModel = tableViewDataAllProjects!.filter({$0.idProjects == "\(selectedButton.tag)"}).first {
            homeController?.addProjectToMyProjects(projectModel)
            viewModel.removeProjectFromAllProjectsList(selectedButton.tag)
            JLToast.makeText("Project \(projectModel.name!) added to MyProjects", duration: JLToastDelay.LongDelay).show()
        }
    }
    
}
