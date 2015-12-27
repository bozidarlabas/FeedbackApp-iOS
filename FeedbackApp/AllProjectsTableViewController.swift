//
//  AllProjectsTableViewController.swift
//  FeedbackApp
//
//  Created by Bozidar on 24.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit
import SwiftyJSON

class AllProjectsTableViewController: UITableViewController {
    
    
    var allProjects: JSON = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllProjects()
//        tableView.estimatedRowHeight = tableView.rowHeight  //estimated height defined in storyboard
//        tableView.rowHeight = UITableViewAutomaticDimension  //calculate dimensions od row
    }
    
    func getAllProjects(){
        let user = getLogedUser()
        print("username: \(user.getUsername())")
        
        RequestAPI.sharedInstance.fetchAllProjects(user.getUsername(), withSuccess: onAllProjectsFetched)
    }
    
    func onAllProjectsFetched(json: JSON)->Void{
        self.allProjects = json
        self.tableView.reloadData()
        print("velicina: \(allProjects.count)")
        print("\(allProjects)")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProjects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("allProjectsCell", forIndexPath: indexPath) as! ProjectsListCell
        cell.labelProjecName.text = allProjects[indexPath.row]["name"].string
        return cell
    }
    
    func getLogedUser()->User{
        let preferenceManager: PreferencesManager = PreferencesManager()
        let user: User = preferenceManager.loadUser()
        return user
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
