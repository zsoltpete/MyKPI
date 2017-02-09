//
//  AnswersCell.swift
//  MyKPI
//
//  Created by Zsolt Pete on 31/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

class AnswersCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.containerView.backgroundColor = UIColor.flatSkyBlue
    }

}
