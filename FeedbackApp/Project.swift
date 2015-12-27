//
//  Project.swift
//  FeedbackApp
//
//  Created by Bozidar on 25.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import Foundation

class Project{
    
    private var id = Int()
    private var name = String()
    private var rating = String()
    
    init(id: Int, name: String, rating: String){
        self.id = id
        self.name = name
        self.rating = rating
    }
    
    func getId()->Int{
        return self.id
    }
    
    func getName()->String{
        return self.name
    }
    
    func getRating()->String{
        return rating
    }
    
}
//
//public static final String ID = "idprojects";
//public static final String NAME = "name";
//public static final String RATING = "rating";