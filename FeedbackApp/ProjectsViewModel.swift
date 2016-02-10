//
//  ProjectsViewModel.swift
//  FeedbackApp
//
//  Created by Bozidar on 02.02.2016..
//  Copyright © 2016. Bozidar. All rights reserved.
//


import SwiftyJSON
import RxSwift
import RxCocoa

class ProjectsViewModel{
    
    var tableViewDataAllProjects = PublishSubject<[ProjectModel]>()
    
    var project: Project?{
        didSet{
            notifyViewController()
        }
    }
    
    var username: String?{
        didSet{
            if username != nil{
                
                fetchAllProjects()
            }
        }
    }
    
    init(){
        username = getLogedUser()
    }
    
    func fetchAllProjects(){
        RequestAPI.sharedInstance.fetchAllProjects(username!, withSuccess: onAllProjectsFetched)
    }
    
    func fetchMyProjects(){
        RequestAPI.sharedInstance.fetchMyProjects(username!, withSuccess: onMyProjectsFetched)
    }
    
    func onAllProjectsFetched(jsonResponse: JSON) -> Void{
        self.project = Project(jsonObject: jsonResponse)
    }
    
    func onMyProjectsFetched(jsonResponse: JSON) -> Void{
        self.project = Project(jsonObject: jsonResponse)
    }
    
    func notifyViewController(){
        tableViewDataAllProjects.on(.Next(project!.projectsModel))
    }
    
    func getLogedUser()->String{
        let preferenceManager: PreferencesManager = PreferencesManager()
        return preferenceManager.loadUser()
    }
    
    func removeProjectFromAllProjectsList(projectId: Int){
        
       project?.projectsModel = (project?.projectsModel.filter { (project : ProjectModel) -> Bool in
            return project.idProjects != "\(projectId)"
        })!
        
        notifyViewController()
    }
    
    func addProject(projectModel: ProjectModel){
        RequestAPI.sharedInstance.addNewProject(username!, projectId: projectModel.idProjects!)
        project?.projectsModel.append(projectModel)
        notifyViewController()
    }
    
    func showPrivateProjects(){
        print("fetch")
        RequestAPI.sharedInstance.fetchPrivateProjects(username!, withSuccess: onMyProjectsFetched)
        notifyViewController()
    }
    
    func showPublicProjects(){
        
    }
    
    func showAllProjects(){
        
    }
    
}
