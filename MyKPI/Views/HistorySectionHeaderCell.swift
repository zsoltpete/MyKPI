//
//  HistorySectionHeaderCell.swift
//  MyKPI
//
//  Created by Zsolt Pete on 29/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

class HistorySectionHeaderCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var shareButton: ShareButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func send(_ sender: Any) {
        self.shareButton.delegate?.share(week: self.shareButton.section!)
    }

}
