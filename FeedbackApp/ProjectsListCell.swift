//
//  AllProjectsListCell.swift
//  FeedbackApp
//
//  Created by Bozidar on 24.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class ProjectsListCell: UITableViewCell {

    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var labelProjecName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
