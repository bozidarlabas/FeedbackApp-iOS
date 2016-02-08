//
//  Project.swift
//  FeedbackApp
//
//  Created by Bozidar on 25.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ProjectModel = (status: String?, idProjects: String?, name: String?, description: String?, rating: Int?)

class Project{
    
    var projectsModel = [ProjectModel]()
    
    
    init(jsonObject: JSON){
        
        if let projectsArray = jsonObject.array{
            for item in projectsArray{
                let projectItem = (
                    status: item["status"].string,
                    idProjects: item["idprojects"].string,
                    name: item["name"].string,
                    description: item["description"].string,
                    rating: item["rating"].int
                )
                projectsModel.append(projectItem)
            }
            
        }
    }
    
}
//
//public static final String ID = "idprojects";
//public static final String NAME = "name";
//public static final String RATING = "rating";