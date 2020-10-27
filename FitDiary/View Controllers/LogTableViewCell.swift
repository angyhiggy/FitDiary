//
//  LogTableViewCell.swift
//  FitDiary
//
//  Created by Angy Higgy on 2020-06-30.
//  Copyright © 2020 Angy Higgy. All rights reserved.
//

import UIKit

class LogTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var foodName: UILabel!
    
    @IBOutlet weak var foodCals: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
