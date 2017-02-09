//
//  BaseButton.swift
//  MyKPI
//
//  Created by Zsolt Pete on 04/02/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

class BaseButton: UIButton {

    func initWith(text: String, inactiveText: String = "Ma már megcsináltad"){
        self.setTitle(text, for: .normal)
        self.setTitle(inactiveText, for: .disabled)
        self.titleLabel?.tintColor = UIColor.white
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.font = UIFont(name: "Arial", size: 20.0)
        self.backgroundColor = UIColor.flatBlueDark
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20.0
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowRadius = 1.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

}
