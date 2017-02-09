//
//  TimePickerViewController.swift
//  MyKPI
//
//  Created by Zsolt Pete on 30/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {
    
    var question: String?

    
    @IBOutlet weak var closeButton: BaseButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var pickerView: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.flatSkyBlue
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        
        let date = dateFormatter.date(from: "00:00")
        
        self.pickerView.date = date!
        self.questionLabel.text = self.question
        self.closeButton.initWith(text: "Rendben")
        self.pickerView.setValue(UIColor.white, forKey: "textColor")
    }
    
    @IBAction func close(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        
        let time = dateFormatter.string(from: self.pickerView.date)
        self.dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Events.AddTimeAnswerEvent), object: time)
        })
        
        
    }

}
