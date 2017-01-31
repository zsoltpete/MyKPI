//
//  BadSideCell.swift
//  MyKPI
//
//  Created by Zsolt Pete on 30/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

class BadSideCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.segmentControl.setTitle("-", forSegmentAt: 0)
        self.segmentControl.setTitle("=", forSegmentAt: 1)
        self.segmentControl.setTitle("-", forSegmentAt: 2)
        self.titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    
}
