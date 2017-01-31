//
//  Question.swift
//  MyKPI
//
//  Created by Zsolt Pete on 28/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

class Question: NSObject, NSCoding {
    
    var id: Int
    var title: String
    var type: String
    var lower: String

    init(title: String, type: String, lower: String = "0"){
        self.title = title
        self.type = type
        self.id = Int(arc4random())
        self.lower = lower
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let type = aDecoder.decodeObject(forKey: "type") as! String
        let lower = aDecoder.decodeObject(forKey: "lower") as! String
        self.init(title: title, type: type, lower: lower)
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(title, forKey: "title")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(lower, forKey: "lower")
    }
}
