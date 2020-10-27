//
//  ExLogTableViewCell.swift
//  FitDiary
//
//  Created by Angy Higgy on 2020-06-30.
//  Copyright © 2020 Angy Higgy. All rights reserved.
//

import UIKit

class ExLogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activityName: UILabel!
    
    @IBOutlet weak var activeTime: UILabel!
    
    @IBOutlet weak var activeCals: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
