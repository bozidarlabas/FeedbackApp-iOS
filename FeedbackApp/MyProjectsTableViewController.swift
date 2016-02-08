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

class MyProjectsTableViewController: UITableViewController {
    
    var tableViewDataMyProjects: [ProjectModel]?
    let disposeBag = DisposeBag()
    let viewModel = ProjectsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        //getMyProjects()
        
        viewModel.fetchMyProjects()
        
        viewModel.tableViewDataAllProjects.subscribeNext{data in
            print("doslo")
            self.tableViewDataMyProjects = data
            self.tableView.reloadData()
        }.addDisposableTo(disposeBag)
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataMyProjects == nil ? 0 : tableViewDataMyProjects!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myProjectsCell", forIndexPath: indexPath) as! ProjectsListCell
        cell.labelProjecName.text = tableViewDataMyProjects![indexPath.row].name
        return cell
    }
    
    func addProject(projectModel: ProjectModel){
        viewModel.addProject(projectModel)
    }

}
