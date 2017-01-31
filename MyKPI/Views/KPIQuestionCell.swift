//
//  KPIQuestionCell.swift
//  MyKPI
//
//  Created by Zsolt Pete on 28/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit
import ActionCell
import MGSwipeTableCell

class KPIQuestionCell: MGSwipeTableCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.questionLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setUp(type: String, lower: String = "0"){
        var leftColor: UIColor = UIColor.red
        var rightColor: UIColor = UIColor.green
        if(lower == "1"){
            leftColor = UIColor.gray
            rightColor = UIColor.gray
        }else if(lower == "2"){
            rightColor = UIColor.red
            leftColor = UIColor.green
        }
        if(type == Constants.QuestionTypes.Point){
            self.rightButtons = [MGSwipeButton(title: "10", backgroundColor: rightColor, padding: Int(self.frame.size.width/18)),
                                 MGSwipeButton(title: "9", backgroundColor: rightColor, padding: Int(self.frame.size.width/18)),
                                 MGSwipeButton(title: "8", backgroundColor: rightColor, padding: Int(self.frame.size.width/18)),
                                 MGSwipeButton(title: "7", backgroundColor: rightColor, padding: Int(self.frame.size.width/18)),
                                 MGSwipeButton(title: "6", backgroundColor: rightColor, padding: Int(self.frame.size.width/18)),
            ]
            self.leftButtons = [MGSwipeButton(title: "0", backgroundColor: leftColor, padding: Int(self.frame.size.width/15)),
                                MGSwipeButton(title: "1", backgroundColor: leftColor, padding: Int(self.frame.size.width/15)),
                                MGSwipeButton(title: "2", backgroundColor: leftColor, padding: Int(self.frame.size.width/15)),
                                MGSwipeButton(title: "3", backgroundColor: leftColor, padding: Int(self.frame.size.width/15)),
                                MGSwipeButton(title: "4", backgroundColor: leftColor, padding: Int(self.frame.size.width/15)),
                                MGSwipeButton(title: "5", backgroundColor: leftColor, padding: Int(self.frame.size.width/15)),
            ]
            self.rightLabel.text = ""
            self.leftLabel.text = ""
        }
        else if(type == Constants.QuestionTypes.Feeling){
            self.leftButtons = [MGSwipeButton(title: "😰", backgroundColor: leftColor, padding: Int(self.frame.size.width/18)),
                                MGSwipeButton(title: "😨", backgroundColor: leftColor, padding: Int(self.frame.size.width/18)),
                                MGSwipeButton(title: "😧", backgroundColor: leftColor, padding: Int(self.frame.size.width/18)),
                                MGSwipeButton(title: "😟", backgroundColor: leftColor, padding: Int(self.frame.size.width/18)),
                                MGSwipeButton(title: "☹️", backgroundColor: leftColor, padding: Int(self.frame.size.width/18)),
            ]
            self.rightButtons = [MGSwipeButton(title: "😂", backgroundColor: rightColor, padding: Int(self.frame.size.width/18)),
                                 MGSwipeButton(title: "😂", backgroundColor: rightColor, padding: Int(self.frame.size.width/18)),
                                 MGSwipeButton(title: "😃", backgroundColor: rightColor, padding: Int(self.frame.size.width/18)),
                                 MGSwipeButton(title: "😋", backgroundColor: rightColor, padding: Int(self.frame.size.width/18)),
                                 MGSwipeButton(title: "🙂", backgroundColor: rightColor, padding: Int(self.frame.size.width/18)),
            ]
            self.rightLabel.text = "😀"
            self.leftLabel.text = "☹️"
        }else if(type == Constants.QuestionTypes.Time){
            
        }else if(type == Constants.QuestionTypes.TrueFalse){
            self.rightButtons = [MGSwipeButton(title: "Volt", backgroundColor: rightColor, padding: Int(self.frame.size.width/2.2))]
            self.leftButtons = [MGSwipeButton(title: "Nem volt", backgroundColor: leftColor, padding: Int(self.frame.size.width/2.4))]
            self.rightLabel.text = ""
            self.leftLabel.text = ""
        }
    }
    
}
