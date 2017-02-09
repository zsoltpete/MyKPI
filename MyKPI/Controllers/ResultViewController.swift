//
//  ResultViewController.swift
//  MyKPI
//
//  Created by Zsolt Pete on 27/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var answers: String?
    
    @IBOutlet weak var statisticButton: BaseButton!
    @IBOutlet weak var sendButton: BaseButton!
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let answersDate = formatter.string(from: date)
        let result = Result(answers: self.answers!, date: answersDate)
        
        var array: [Result] = [Result]()
        
            if let decoded = UserDefaults.standard.object(forKey: "Results") as? Data {
                array = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as! [Result]
            }
        
        
        array.append(result)
        
        
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: array), forKey: "Results")
        UserDefaults.standard.synchronize()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.flatSkyBlue
        self.sendButton.initWith(text: "Gyors küldés")
        self.statisticButton.initWith(text: "Statisztika")
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func export(_ sender: Any) {
        self.saveAndExport(string:self.answers!)
    }
    
    
    
}
