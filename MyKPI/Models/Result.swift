//
//  Result.swift
//  MyKPI
//
//  Created by Zsolt Pete on 29/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

class Result: NSObject, NSCoding {
    
    var answers: String
    var date: String
    
    init(answers: String, date: String){
        self.answers = answers
        self.date = date
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let answers = aDecoder.decodeObject(forKey: "answers") as! String
        let date = aDecoder.decodeObject(forKey: "date") as! String
        self.init(answers: answers, date: date)
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(answers, forKey: "answers")
        aCoder.encode(date, forKey: "date")
    }
}
