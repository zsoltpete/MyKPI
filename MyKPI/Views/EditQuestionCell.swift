//
//  EditQuestionCell.swift
//  MyKPI
//
//  Created by Zsolt Pete on 28/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class EditQuestionCell: MGSwipeTableCell {
    
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.questionTitleLabel.adjustsFontSizeToFitWidth = true
    }
}
