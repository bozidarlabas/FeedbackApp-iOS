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

class AllProjectsTableViewController: UITableViewController {
    
    
    var tableViewDataAllProjects: [ProjectModel]?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.getAllProjects()
        let viewModel = ProjectsViewModel()
        viewModel.fetchAllProjects()
        
        viewModel.tableViewDataAllProjects.subscribeNext{data in
            self.tableViewDataAllProjects = data
            self.tableView.reloadData()
        }.addDisposableTo(disposeBag)

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataAllProjects == nil ? 0 : tableViewDataAllProjects!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("allProjectsCell", forIndexPath: indexPath) as! ProjectsListCell
        cell.labelProjecName.text = tableViewDataAllProjects![indexPath.row].name
        return cell
    }
    
}
